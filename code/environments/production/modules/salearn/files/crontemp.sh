#!/bin/sh
host='example.com'
#for real user #
#
#cat /etc/passwd | grep /home | cut -d: -f1  > users
/usr/local/bin/mysql -uvscan -h 10.10.6.94 -e "use postfix; select username from mailbox" > /tmp/users_tmp
/usr/bin/sed -i '' -e '1,1d' /tmp/users_tmp


while read p; do
  local_part=$(echo $p|cut -d '@' -f1)
  domain=$(echo $p|cut -d '@' -f2)
  
  /usr/local/bin/sa-learn -u $p --spam /usr/local/virtual/'$domain'/'$local_part'/.Spam/{cur,new}
  /usr/local/bin/sa-learn -u $p --ham /usr/local/virtual/'$domain'/'$local_part'/{cur,new}
done </tmp/users_tmp
#postmap /usr/local/etc/postfix/virtual
#rm users
