#!/usr/bin/bash

echo "######################################"
echo "# install-google-ops-agent.sh"
echo "######################################" 

curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install
