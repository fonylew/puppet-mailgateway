#!/bin/sh

# Require files from local host
# ** Do it with scp or whatever you want to copy it to remote host
# cp /etc/rc.d/puppet ~ 
# cp /etc/rc.d/puppetmaster ~
# cp /etc/puppetlabs/puppet/puppet.conf ~
# cp /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb ~

echo "Please enter puppetmaster's IP :"
read IP

mkdir -p /usr/local/etc/pkg/repos
echo "FreeBSD: { enabled: no }" > /usr/local/etc/pkg/repos/FreeBSD.conf
echo 'PuppetRepo: { url: "pkg+http://puppetmaster/pkg", mirror_type: "srv", enabled: yes }' > /usr/local/etc/pkg/repos/FreeBSD.conf
cd ~
pkg update
pkg install -y ruby
pkg install -y ruby21-gems
gem install puppet
pkg install -y ca_root_nss
pkg install -y vim-lite
mkdir -p /etc/puppetlabs/code/environments/production/modules
mkdir -p /etc/puppetlabs/code/manifests
mkdir -p /etc/puppetlabs/puppet

cp pkgng.rb /usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb

cp puppet /etc/rc.d/
#cp puppetmaster /etc/rc.d/
cp puppet.conf /etc/puppetlabs/puppet

echo 'puppet_enable="YES"' >> /etc/rc.conf
#echo 'puppetmaster_enable="YES"' >> /etc/rc.conf

echo "$IP		puppetmaster host" >> /etc/hosts

echo 'puppet::::::::::' | adduser -w no -f
