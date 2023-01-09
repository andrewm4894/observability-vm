#!/usr/bin/bash

echo "######################################"
echo "# thebox.sh"
echo "######################################" 

# prepare

${prepare}

# install

${install-docker}
${install-netdata}
${install-prometheus}
${install-grafana}
${install-datadog}
${install-google-ops-agent}
${install-influxdb}
${install-telegraf}
${install-akita}

# configure

${configure-influxdb}
${configure-cronjobs}

# deploy

${deploy-opentelemetry-demo-app}

echo "######################################"
echo "# FINISHED!!!"
echo "######################################"
