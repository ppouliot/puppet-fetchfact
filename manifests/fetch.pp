define fetchfact::fetch ( $url, $factfile ) {

  include fetchfact
  #path = "/etc/puppetlabs/facter/facts.d/${factfile}"
  
  case $::kernel {
    'Linux':{
      $local_fact_path = "/etc/facter/facts.d"
    }
    'windows':{
      $local_fact_path = "C:/ProgramData/PuppetLabs/facter/facts.d"
    }
    default:{
      $local_fact_path = "/etc/puppetlabs/facter/facts.d"
    }
  }
  local_fact_file = "${local_fact_path}/${fact_file}"

  case $factfile {
    /.*\.json$/: {
      case $osfamily {
        'redhat': {
          package { 'rubygem-json':
            ensure => installed
          }
        }
        
        'debian','suse': {
          package { 'ruby-json':
            ensure => installed
          }
        }
        default: {
          package { 'json':
            ensure   => installed,
            provider => gem
          }
        }
      }
    }
    default: {
      # nothing to do -- YAML and .txt support
      # relies on no external packages
    }
  }

  wget::fetch { $url:
    source      => $url,
    destination => $local_fact_file,
    require     => File[$fact_path]
  }

}
