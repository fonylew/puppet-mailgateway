class dovecot{
	package{'dovecot-pigeonhole' :
		ensure => 'present',
	}

	package{'dovecot2' :
		ensure => 'present',
	}

        $pkg='dovecot'   
        $str="${pkg}_enable=\"YES\""
        exec {'rcconf-dovecot':
                command => "echo ${str}>> /etc/rc.conf",
                path => ['/bin','/usr/bin/'],
                unless=> "grep ${str} /etc/rc.conf",
                require => Package["${pkg}2"],
        }

	file{'/usr/local/etc/dovecot' :
		source => 'puppet:///modules/dovecot/dovecot',
		recurse => 'true',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/virtual/home' :
		ensure => 'directory',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	file{'/usr/local/virtual/home/default.sieve' :
		ensure => 'file',
		source => 'puppet:///modules/dovecot/default.sieve',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	exec{'sievec /usr/local/virtual/home/default.sieve' :
		path => '/usr/local/bin',
		subscribe => File['/usr/local/virtual/home/default.sieve'],
	}

	file{'/usr/local/virtual' :
		ensure => 'directory',
		owner => 'vscan',
		group => 'vscan',
		mode => '0777',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
		recurse => 'true',
	}

	exec{'pw usermod dovecot -G vscan' :
		path => '/usr/sbin',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}
	
	file{'/usr/local/etc/ssl/dovecot' :
		ensure => 'directory',
		require => [Package['dovecot-pigeonhole'],Package['dovecot2']],
	}

	exec{'openssl req -passin pass:pass -new -x509 -nodes -out cert.pem -keyout key.pem -days 3650 -subj "/CN=www.example.com/O=Example/C=TH/ST=Bangkok/L=Bangkok"' :
		path => '/usr/bin',
		cwd => '/usr/local/etc/ssl/dovecot',
		require => File['/usr/local/etc/ssl/dovecot'],
	}

	file{'/usr/local/libexec/dovecot/dovecot-lda':
		ensure => 'present',
		group => 'vscan',
		mode => '04750',
	}
	file{'/usr/local/libexec/dovecot/deliver':
		ensure => 'present',
		group => 'vscan',
		mode => '04750',
	}
}	
