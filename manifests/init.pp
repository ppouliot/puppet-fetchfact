class fetchfact {

  file { '/etc/puppetlabs/facter':
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755'
  }

  file { '/etc/puppetlabs/facter/facts.d':
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => File['/etc/puppetlabs/facter']
  }
}
