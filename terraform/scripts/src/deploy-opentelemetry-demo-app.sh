#!/usr/bin/bash

echo "######################################"
echo "# deploy-opentelemetry-demo-app.sh"
echo "######################################" 

# https://github.com/open-telemetry/opentelemetry-demo/blob/main/docs/docker_deployment.md
cd ~
git clone https://github.com/open-telemetry/opentelemetry-demo.git
cd opentelemetry-demo/
#sudo sed -i 's/GRAFANA_SERVICE_PORT=3000/GRAFANA_SERVICE_PORT=3001/g' .env
#sudo sed -i 's/PROMETHEUS_SERVICE_PORT=9090/PROMETHEUS_SERVICE_PORT=9091/g' .env
docker compose up -d --no-build
