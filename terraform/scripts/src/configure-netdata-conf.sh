#!/usr/bin/bash

echo "######################################"
echo "# configure-netdata-conf.sh"
echo "######################################" 

echo 'creating netdata.conf'
sudo cat <<EOT > /etc/netdata/netdata.conf
[ml]
    enabled = yes
    enable statistics charts = yes
EOT
