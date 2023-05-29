#!/usr/bin/bash

echo "######################################"
echo "# ml-demo-ml-enabled.sh"
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
[cloud]
    conversation log= yes
[ml]
    enabled = yes
    enable statistics charts = yes
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
