#!/usr/bin/bash

echo "######################################"
echo "# install-netdata-fe.sh"
echo "######################################" 

# make dirs
mkdir /src
cd /src

# clone repos
echo "${gh-token}" > gh-token
gh auth login --with-token < gh-token
rm -f gh-token
gh auth status
gh repo clone netdata/charts -- --branch ${netdata-charts-branch}
gh repo clone netdata/cloud-frontend -- --branch ${netdata-cloud-frontend-branch}

# update repos locally
cd /src/cloud-frontend
yarn
cd /src/charts
yarn && sudo yarn to-cloud

# run script to update ui
cd /src/cloud-frontend

# make agent.sh script 
# curl from https://gist.github.com/andrewm4894/8e44678923b92a292ec8bdbf858ae9de
curl -sS https://gist.githubusercontent.com/andrewm4894/8e44678923b92a292ec8bdbf858ae9de/raw/agent.sh > /src/cloud-frontend/agent.sh

# make script executable
chmod +x /src/cloud-frontend/agent.sh

# run script
sudo /src/cloud-frontend/agent.sh