#!/usr/bin/bash

echo "######################################"
echo "# install-grafana.sh"
echo "######################################" 

sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key

echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update -y

sudo apt-get install grafana-enterprise -y

sudo systemctl daemon-reload
sudo systemctl start grafana-server

sudo systemctl enable grafana-server.service

sudo grafana-cli admin reset-admin-password ${grafana-password}
