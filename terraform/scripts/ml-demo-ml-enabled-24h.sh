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
    maximum num samples to train = 21600
    train every = 10800
    number of models per dimension = 9
    enable statistics charts = yes
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
