#!/bin/bash
#turn off swap memory
echo -e "${RED}-----PreRequire ubuntu > 20.04----- ${ENDCOLOR}"
echo -e "${RED}-----Turn off swap memory----- ${ENDCOLOR}"
sudo swapoff -a

#Set up the IPV$ bridge on all nodes
echo -e "${RED}-----Set up the IPV$ bridge on all nodes----- ${ENDCOLOR}"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
echo -e "${RED}-----sysctl params required by setup, params persist across reboots----- ${ENDCOLOR}"
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
echo -e "${RED}-----Apply sysctl params without reboot----- ${ENDCOLOR}"
sudo sysctl --system

#install containerd
echo -e "${RED}-----install containerd----- ${ENDCOLOR}"
## Add Docker's official GPG key:
echo -e "${RED}-----Add Docker's official GPG key----- ${ENDCOLOR}"
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## install docker & containerd
echo -e "${RED}-----install docker & containerd----- ${ENDCOLOR}"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermode -aG docker $USER

# config containerd
echo -e "${RED}-----config containerd----- ${ENDCOLOR}"
sudo mkdir /etc/containerd
sudo sh -c "containerd config default > /etc/containerd/config.toml"
sudo sed -i 's/            SystemdCgroup = false/            SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl restart kubelet.service
sudo systemctl enable kubelet.service

#install kubectl
echo -e "${RED}-----install kubectl----- ${ENDCOLOR}"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

#install kubeadm
echo -e "${RED}-----install kubeadm----- ${ENDCOLOR}"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

#initalize cluster
echo -e "${RED}-----initalize cluster----- ${ENDCOLOR}"
sudo kubeadm init --pod-network-cidr 192.168.0.0/16

#add kubeconfig
echo -e "${RED}-----add kubeconfig----- ${ENDCOLOR}"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#install calico network plugin
echo -e "${RED}-----install calico network plugin----- ${ENDCOLOR}"
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/calico.yaml -O
kubectl apply -f calico.yaml

#join the worker
echo -e "${RED}-----Command for worker join cluster----- ${ENDCOLOR}"
kubeadm token create --print-join-command

#sudo...
echo -e "${RED}-----Running command in worker nodes with sudo or root----- ${ENDCOLOR}"