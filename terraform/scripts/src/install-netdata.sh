#!/usr/bin/bash

echo "######################################"
echo "# install-netdata.sh"
echo "######################################" 

sudo wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && \
  sh /tmp/netdata-kickstart.sh \
  --claim-token ${netdata-claim-token} \
  --claim-url https://app.netdata.cloud
