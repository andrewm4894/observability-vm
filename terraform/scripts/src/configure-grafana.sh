#!/usr/bin/bash

echo "######################################"
echo "# configure-grafana.sh"
echo "######################################" 

# create grafana.conf
sudo cat <<EOT > /etc/grafana/grafana.ini
# Configuration for grafana
[server]
http_port=3001
EOT

sleep 10
sudo systemctl restart grafana
