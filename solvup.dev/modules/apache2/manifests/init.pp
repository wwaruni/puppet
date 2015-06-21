class apache2 {
    package { "apache2-package":
        name   => 'apache2',
        ensure => present,
    }

    package { "apach2-php-mod":
        name    => "libapache2-mod-php5",
        ensure  => present,
        require => [Package["apache2-package"]],
    }

    service { "apache2-service":
        name       => "apache2",
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        require    => Package["apache2-package"],
    }

    file { "enable-rewrite":
        path => "/etc/apache2/mods-enabled/rewrite.load",
        target => "/etc/apache2/mods-available/rewrite.load",
        ensure => link,
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }

    file { "apache2-default-conf":
        path    => "/etc/apache2/sites-enabled/000-default.conf",
        owner   => root,
        group   => root,
        ensure  => present,
        source  => "puppet:///modules/apache2/000-default.conf",
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }

    file { "apache2-solvup-host":
        path    => "/etc/apache2/sites-enabled/solvup.com.au.conf",
        owner   => root,
        group   => root,
        ensure  => present,
        source  => "puppet:///modules/apache2/solvup.com.au.conf",
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }

    file { "apache2-ssl-conf":
        path    => "/etc/apache2/sites-available/default-ssl.conf",
        owner   => root,
        group   => root,
        ensure  => present,
        source  => "puppet:///modules/apache2/default-ssl.conf",
        require => [ Package["apache2"], Package["php5-common"], Package["libapache2-mod-php5"] ],
        notify  => Exec["apache2-restart"],
    }

    exec { "apache2-restart":
        command     => "/etc/init.d/apache2 restart",
        refreshonly => true,
    }
}
