class fetchfact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = "/etc/factor"
    }
    'windows':{
      $local_facter_base_path = "C:/ProgramData/PuppetLabs/facter"
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
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
