class roundcube{
	package{'roundcube':
		ensure => 'present',
	}
	package{'php56-fileinfo':
		ensure => 'present',
	}
	file{'/usr/local/etc/apache24/Includes/roundcube.conf':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/roundcube.conf',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/config/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/config.inc.php',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/plugins/managesieve/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/plugins-managesieve-config.inc.php',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/plugins/password/config.inc.php':
		ensure => 'file',
		mode => '0755',
		source => 'puppet:///modules/roundcube/plugins-password-config.inc.php',
		require => Package['roundcube'],
	}
	exec{'importsql':
		path => '/usr/local/bin',
		cwd => '/usr/local/www/roundcube/SQL',	
		command => 'mysql -uroundcube roundcube < mysql.initial.sql',
		require => Package['roundcube'],
	}
	file{'/usr/local/www/roundcube/plugins/amacube':
		ensure => 'directory',
		source => 'puppet:///modules/roundcube/amacube',
		recurse => 'true',
		require => Package['roundcube'],
	}
}
