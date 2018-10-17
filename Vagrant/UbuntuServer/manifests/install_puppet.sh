#!/bin/sh
set -e -x

if which puppet > /dev/null ; then
    echo "Puppet is already installed"
    exit 0
fi

export DEBIAN_FRONTEND=noninteractive
wget -qO /tmp/puppet-release-xenial.deb https://apt.puppetlabs.com/puppet-release-xenial.deb

dpkg -i /tmp/puppet-release-xenial.deb
rm /tmp/puppet-release-xenial.deb
apt-get update
echo Installing puppet
apt-get install -y puppet
echo "Puppet installed!"