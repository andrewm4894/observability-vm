#!/usr/bin/bash

echo "######################################"
echo "# install-datadog.sh"
echo "######################################" 

DD_API_KEY=${datadog-api-key} DD_SITE="${datadog-site}" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"
