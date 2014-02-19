# Class: tomcat::install
#
#
class tomcat::install (
  $install_java           =   true,
  $package_provider       =   undef,
  $package_name           =   'apache-tomcat',
  $additional_packages    =   undef,
  $version                =   '7.0.50',
  $archive_download_dir   =   '/usr/local/src',
  $archive_target_dir     =   undef,
  $manage_user            =   true,
  $tomcat_user            =   'tomcat',
  $manage_group           =   true,
  $tomcat_group           =   'tomcat',
  $remove_default_apps    =   true,
  $remove_default_manager =   true
  ) {

  if $install_java {

    if $::osfamily == 'redhat' {
      if ! defined(Package['java-1.7.0-openjdk']){
        package { 'java-1.7.0-openjdk':
          ensure => latest,
        }
      }
      if ! defined(Package['java-1.7.0-openjdk-devel']){
        package { 'java-1.7.0-openjdk-devel':
          ensure  => latest,
          require => Package['java-1.7.0-openjdk'],
        }
      }
    }
  } # End install java

  if $package_provider {
    if $package_provider == 'archive' {
      class { 'tomcat::install::archive':
        version                =>  $version,
        package_name           =>  $package_name,
        archive_download_dir   =>  $archive_download_dir,
        archive_target_dir     =>  $archive_target_dir,
        manage_user            =>  $manage_user,
        tomcat_user            =>  $tomcat_user,
        manage_group           =>  $manage_group,
        tomcat_group           =>  $tomcat_group,
        remove_default_apps    =>  $remove_default_apps,
        remove_default_manager =>  $remove_default_manager
      }
    } else {
      package { $package_name:
        ensure    => $version,
        provider  => $package_provider
      }

      if $additional_packages {
        package { $additional_packages:
          ensure    => installed,
          provider  => $package_provider
        }
      }
    }
  }


} # End of class