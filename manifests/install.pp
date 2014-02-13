# Class: tomcat::install
#
#
class tomcat::install (
  $install_java       =   true,
  $version            =   '7.0.50',
  $package_provider   =   'staging',
  $tar_source_uri     =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $unpack_dir         =   '/usr/local/src'
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

  if $package_provider == 'staging' {
    class { 'tomcat::install::staging':
      tar_source_uri  =>  $tar_source_uri,
      version         =>  $version,
      unpack_dir      =>  $unpack_dir
    }
  }

}