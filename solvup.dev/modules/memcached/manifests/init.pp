class memcached {
  package { "memcached-server":
    name    => "memcached",
    ensure  => present,
  }

  service { "memcached_service":
    name       => "memcached",
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    require    => Package["memcached-server"]
  }
}
