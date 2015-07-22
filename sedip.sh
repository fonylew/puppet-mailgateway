#!/bin/sh
find /etc/puppetlabs/code/environments/production/modules/ -type f -print0 | xargs -0 sed -i '' 's/10.10.6.91/10.10.6.94/g' 
