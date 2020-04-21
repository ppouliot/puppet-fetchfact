class fetchfact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = "/etc/facter"
      File {
        owner => 'root',
        group => 'root',
      }
    }
    'windows':{
      $local_facter_base_path = "C:/ProgramData/PuppetLabs/facter"
      File {
        owner => 'PUP_LCL_ACCOUNT_ADMINISTRATORS',
        group => 'PUP_LCL_ACCOUNT_ADMINISTRATORS',
      }
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
      File {
        owner => 'root',
        group => 'root',
      }
    }
  }

  file { $local_facter_base_path:
    ensure => directory,
    mode   => '0755'
  }

  file { "${local_facter_base_path}/facts.d":
    ensure  => directory,
    mode    => '0755',
    require => File[$local_facter_base_path]
  }
}
