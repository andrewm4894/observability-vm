#!/usr/bin/bash

echo "######################################"
echo "# install-akita.sh"
echo "######################################" 

docker run --rm --network host \
  -e AKITA_API_KEY_ID=${akita-api-key} \
  -e AKITA_API_KEY_SECRET=${akita-api-secret} \
  akitasoftware/cli:latest apidump \
  --project dev
