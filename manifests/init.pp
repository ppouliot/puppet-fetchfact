class fetchfact {

  case $::kernel {
    'Linux':{
      $local_factor_base_path = "/etc/factor"
    }
    'windows':{
      $local_factor_base_path = "C:/ProgramData/PuppetLabs/factor"
    }
    default:{
      $local_factor_base_path = "/etc/puppetlabs/factor"
    }
  }
  
  file { $local_factor_base_path:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755'
  }

  file { "${local_factor_base_path}/facts.d":
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    require => File[$local_factor_base_path]
  }
}
