#!/bin/bash
echo "dl.google.com"
nslookup dl.google.com | grep Address: | awk 'NR>1 {print $2}'
echo "gcr.io"
nslookup gcr.io | grep Address: | awk 'NR>1 {print $2}'
echo "www.googleapis.com"
nslookup www.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "accounts.google.com"
nslookup accounts.google.com | grep Address: | awk 'NR>1 {print $2}'
echo "anthos.googleapis.com"
nslookup anthos.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "anthosgke.googleapis.com"
nslookup anthosgke.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "cloudresourcemanager.googleapis.com"
nslookup cloudresourcemanager.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "compute.googleapis.com"
nslookup compute.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "connectgateway.googleapis.com"
nslookup connectgateway.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "container.googleapis.com"
nslookup container.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "gkeconnect.googleapis.com"
nslookup gkeconnect.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "gkehub.googleapis.com"
nslookup gkehub.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "gkeonprem.googleapis.com"
nslookup gkeonprem.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "gkeonprem.mtls.googleapis.com"
nslookup gkeonprem.mtls.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "iam.googleapis.com"
nslookup iam.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "iamcredentials.googleapis.com"
nslookup iamcredentials.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "logging.googleapis.com"
nslookup logging.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "monitoring.googleapis.com"
nslookup monitoring.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "oauth2.googleapis.com"
nslookup oauth2.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "opsconfigmonitoring.googleapis.com"
nslookup opsconfigmonitoring.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "securetoken.googleapis.com"
nslookup securetoken.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "servicecontrol.googleapis.com"
nslookup servicecontrol.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "serviceusage.googleapis.com"
nslookup serviceusage.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "stackdriver.googleapis.com"
nslookup stackdriver.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "storage.googleapis.com"
nslookup storage.googleapis.com | grep Address: | awk 'NR>1 {print $2}'
echo "sts.googleapis.com"
nslookup sts.googleapis.com | grep Address: | awk 'NR>1 {print $2}'