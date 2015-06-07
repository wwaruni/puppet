class php {
    package { "php5-common":
        ensure => present,
        require => Package["apache2"],
        notify => Exec["apache2-restart"],
    }
    package { "php5-mysql":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-memcached":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-apcu":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-gd":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-imagick":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-mcrypt":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    file { "enable-php5-mcrypt":
        path => "/etc/php5/apache2/conf.d/20-mcrypt.ini",
        target => "/etc/php5/conf.d/mcrypt.ini",
        ensure => link,
        require => Package["php5-mcrypt"],
        notify  => Exec["apache2-restart"],
    }
    package { "php5-intl":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-curl":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    package { "php5-json":
        ensure => present,
        require => [Package["php5-common"]],
        notify => Exec["apache2-restart"],
    }
    file { "/etc/php5/cli/php.ini":
        owner   => root,
        group   => root,
        source  => "puppet:///modules/php/php.ini",
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }
    file { "/etc/php5/apache2/php.ini":
        owner   => root,
        group   => root,
        source  => "puppet:///modules/php/php.ini",
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }
}
