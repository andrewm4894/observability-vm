#!/usr/bin/bash

echo "######################################"
echo "# ml-demo-ml-enabled.sh"
echo "######################################" 

# prepare

${prepare}

# install

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
    number of models per dimension = 1
    enable statistics charts = yes
EOT

sudo systemctl restart netdata

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
