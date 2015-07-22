class salearn{
	file{'/tmp/crontemp.sh':
		ensure => 'file',
		source => 'puppet:///modules/salearn/crontemp.sh',
		owner => 'vscan',
		mode => '0755',
	}
	cron{'runcron':
		ensure => 'present',
		command => 'sh /tmp/crontemp.sh',
		month => 'absent',
		monthday => 'absent',
		weekday => 'absent',
		hour => 'absent',
		minute => '*/10',
		user => 'root',
		require => File['/tmp/crontemp.sh'],
	}
}
