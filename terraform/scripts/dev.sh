#!/usr/bin/bash

echo "######################################"
echo "# dev.sh"
echo "######################################" 

# prepare

${prepare}

# install

${install-stress-ng}
${install-docker}
${install-netdata}

# configure

echo 'creating netdata.conf'
sudo cat <<EOT > /etc/netdata/netdata.conf
[ml]
    enable statistics charts = yes
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
