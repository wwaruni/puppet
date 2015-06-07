class setup {
    exec { "apt-update" :
        command => "/usr/bin/apt-get -qy update",
    }
    exec { "apt-upgrade" :
        command => "/usr/bin/apt-get -qy upgrade",
        require => [Exec["apt-update"]],
    }
}

class essentials {
    package { "vim-nox":
        ensure => present,
    }

    package { "htop":
        ensure => present,
    }

    package { "curl":
        ensure => present,
    }

    package { "ntp":
        ensure => present,
    }

    package { "ntpdate":
        ensure => present,
    }
}

node default {
    include setup
    include essentials
    include memcached
    include apache2
    include php
}
