# puppet-amavisd
---
# Installation
First, copy necessary files to the directory where installpuppet.sh will be running

- rc.d/puppet
- rc.d/puppetmaster
- puppet/puppet.conf
- etc/pkgng.rb

### For puppetmaster
use [`etc/installpuppetmaster.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/installpuppetmaster.sh) script to install required packages and gems, create directory structure and patch the copied necessary files to their proper locations.

### For puppet client
use [`etc/installpuppet.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/installpuppet.sh) instead.

Notes: 
[**pkgng**](https://github.com/biggun002/puppet-amavisd/blob/master/etc/pkgng.rb) was also edited here to optimize runtime
`
/usr/local/lib/ruby/gems/2.1/gems/puppet-4.2.0/lib/puppet/provider/package/pkgng.rb
`

---

# Module
In order to use package compiled from port, Puppet only lookup package in **pkg**. So, we have to host own package repository. First, list the package you want to create in `packagelist` file and run this script in `/usr/local/www/pkg` 
[`etc/finddependeccies.sh`](https://github.com/biggun002/puppet-amavisd/blob/master/etc/finddependencies.sh).

run `pkg` on newly installed machine once.

#### To use localhost's package repository:

* Disable default repository

```bash
mkdir -p /usr/local/etc/pkg/repos
echo "FreeBSD: { enabled: no }" > /usr/local/etc/pkg/repos/FreeBSD.conf
```
* Add these lines to `/etc/pkg/FreeBSD.conf`

```bash
echo "Self: { url: 'pkg+http://localhost/pkg', mirror_type: 'srv', enabled: yes }" > /usr/local/etc/pkg/repos/FreeBSD.conf
```
\* both commands were already included in `installpuppet.sh`

When you want to restore everything back to normal state, simply remove `/usr/local/etc/pkg/repos/FreeBSD.conf` file.

---

#Puppet client
First, edit `certname` in `/etc/puppetlabs/puppet/puppet.conf` to be the unique name.

make sure that puppetserver address is the correct one.

Then, in puppet client, run 

```
puppet agent -t
```
Note: You can list all certificates with `puppet cert list --all` command. If `certname` isn't unique, you can remove the duplicate on with command `puppet cert clean <certname>` in puppetmaster machine.

---
#Puppetmaster
In newer version, puppetserver was renamed to **puppetmaster**.

We used puppetmaster machine as MySQL server for storing mails and configurations in database, LDA (Dovecot) and Spamassassin for learning bayes per user.

required puppet modules for puppetmaster machine:

- adminer
- apache
- dovecot
- mysqlcon
- pear
- php
- postfixadmin
- roundcube
- salearn
- saupdate
- spamassassin

`etc/puppetmasterapply.sh` is the script to apply all required puppet modules once.
