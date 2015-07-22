#node 'host'{
#	include adduser
#	include	php
#	include apache
#	include mysqlcon
#	include pear
#	include dovecot
#	include spamassassin
#	include saupdate
#	include postfixadmin
#	include adminer
#	include roundcube
#	include salearn	
#}

node default{
    #include mysqlcon
    #include php
    #include apache
    include clamav
    include amavisd
    #include pear
    include postfix
	#include adduser
	include saupdate
	include spamassassin
	#include roundcube
	#include salearn
}
