#!/usr/bin/bash

echo "######################################"
echo "# install-netdata.sh"
echo "######################################" 

if [ "${netdata-fork}" = "kickstart" ]; then
    echo 'installing netdata using kickstart'
    sudo wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && \
        sh /tmp/netdata-kickstart.sh \
        --non-interactive \
        --nightly-channel \
        --claim-token ${netdata-claim-token} \
        --claim-url ${netdata-claim-url}
elif [ "${netdata-fork}" = "kickstart nightly" ]; then
    echo 'installing netdata using kickstart nightly'
    sudo wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && \
        sh /tmp/netdata-kickstart.sh \
        --non-interactive \
        --nightly-channel \
        --claim-token ${netdata-claim-token} \
        --claim-url ${netdata-claim-url}
elif [ "${netdata-fork}" = "kickstart stable" ]; then
    echo 'installing netdata using kickstart stable'
    sudo wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh && \
        sh /tmp/netdata-kickstart.sh \
        --non-interactive \
        --stable-channel \
        --claim-token ${netdata-claim-token} \
        --claim-url ${netdata-claim-url}
else
    echo 'installing netdata from fork/branch'
    rm -r -f netdatatmpdir
    mkdir netdatatmpdir
    sudo curl -Ss 'https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/install-required-packages.sh' > netdatatmpdir/install-required-packages.sh && bash netdatatmpdir/install-required-packages.sh --dont-wait --non-interactive netdata
    sudo curl -Ss 'https://raw.githubusercontent.com/netdata/netdata/master/packaging/installer/install-required-packages.sh' > netdatatmpdir/install-required-packages.sh && bash netdatatmpdir/install-required-packages.sh --dont-wait --non-interactive netdata-all
    git clone --branch ${netdata-branch} "https://github.com/${netdata-fork}.git" --depth=100
    cd /netdata
    git submodule update --init --recursive
    sudo ./netdata-installer.sh --dont-wait

    echo 'claiming to cloud'
    sudo netdata-claim.sh -token=${netdata-claim-token} -url=${netdata-claim-url}
fi
