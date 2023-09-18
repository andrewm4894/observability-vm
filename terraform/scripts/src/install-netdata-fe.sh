#!/usr/bin/bash

echo "######################################"
echo "# install-netdata-fe.sh"
echo "######################################" 

# make dirs
mkdir src
cd src

# clone repos
gh repo clone netdata/charts -- --branch ${netdata-charts-branch}
gh repo clone netdata/cloud-frontend -- --branch ${netdata-cloud-frontend-branch}

# update repos locally
cd cloud-frontend
yarn
cd ..
cd charts
yarn && sudo yarn to-cloud
cd ..

# run script to update ui
cd cloud-frontend

# make agent.sh script 
cat <<EOT > agent.sh
#!/usr/bin/env bash

#scope="testing"
scope="production"

# stop on all errors
set -e

if [ \$UID -ne 0 ]
then
	echo >&2 "Hey! sudo me: sudo ${0}"
	exit 1
fi

echo >&2 "Finding the local netdata web directory..."
webdir=$(curl -sS 'http://localhost:19999/netdata.conf' |\
	sed -n '/\[directories\]/,/^ *$/p' |\
	grep -E '.*[[:space:]]web[[:space:]]*=[[:space:]]' |\
	sed 's/.*[[:space:]]web[[:space:]]*=[[:space:]]\(.*\)/\1/')

if [ -z "$${webdir}" -o ! -d "$${webdir}" ]
then
	echo >&2 "Cannot find netdata web directory"
	exit 1
fi

echo >&2 "Netdata web directory is '$${webdir}'"

echo >&2 "Running yarn install..."
yarn install

echo >&2 "Running yarn build..."
ENV="$${scope}" yarn build

echo >&2 "Copying dashboard files to '$${webdir}"

[ ! -d $${webdir}/v1 ] && mkdir -p $${webdir}/v1
[ ! -d $${webdir}/v2 ] && mkdir -p $${webdir}/v2

#version="$(git describe --tag | cut -d '-' -f 1)"
#
cp -R dist/* $${webdir}/v2/
cp dist/registry-hello.html $${webdir}/
cp dist/registry-access.html $${webdir}/
cp dist/registry-alert-redirect.html $${webdir}/
cp --no-clobber $${webdir}/index.html $${webdir}/v1/index.html || echo >/dev/null
cp dist/agent.html $${webdir}/index.html
cp dist/local-agent.html $${webdir}/v2/index.html

echo >&2 "CREATING TAR in /tmp/agent-varlibnetdataweb.tar.gz ..."
[ -f /tmp/agent-varlibnetdataweb.tar.gz ] && rm -f /tmp/agent-varlibnetdataweb.tar.gz
old="$(pwd)"
cd "$${webdir}" || exit 1
tar -zcpf /tmp/agent-varlibnetdataweb.tar.gz v2/* registry-hello.html registry-access.html registry-alert-redirect.html index.html || exit 1
cd "$${old}" || exit 1

#ENV="agent" yarn start

#echo >&2 "RUNNING..."
#sudo yarn dev-$${scope}
EOT

chmod +x agent.sh
sudo ./agent.sh