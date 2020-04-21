define fetchfact::fetch ( $url, $factfile ) {

  include fetchfact
  #path = "/etc/puppetlabs/facter/facts.d/${factfile}"

  case $::kernel {
    'Linux':{
      $local_fact_path = "/etc/facter/facts.d"
      $path = "${local_fact_path}/${factfile}"
    }
    'windows':{
      $local_fact_path = "C:/ProgramData/PuppetLabs/facter/facts.d"
      $path = "${local_fact_path}/${factfile}"
    }
    default:{
      $local_fact_path = "/etc/puppetlabs/facter/facts.d"
      $path = "${local_fact_path}/${factfile}"
    }
  }

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
    destination => $path,
    require     => File[$local_fact_path]
  }

}
