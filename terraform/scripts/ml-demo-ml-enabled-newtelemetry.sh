#!/usr/bin/bash

echo "######################################"
echo "# ml-demo-ml-enabled-newconf.sh"
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
    enabled = yes
    minimum num samples to train = 900
    maximum num samples to train = 14400
    train every = 3600
    number of models per dimension = 2
    enable statistics charts = yes
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!"
echo "######################################"
