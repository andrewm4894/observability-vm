#!/usr/bin/bash

echo "######################################"
echo "# ml-demo-ml-disabled.sh"
echo "######################################" 

# prepare

${prepare}

# install

${install-stress-ng}
${install-docker}
${install-netdata}

# configure

${configure-cronjobs}

echo 'creating netdata.conf'
sudo cat <<EOT > /etc/netdata/netdata.conf
[ml]
    enabled = no
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
