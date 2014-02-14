# Class: tomcat::install
#
#
class tomcat::install (
  $install_java         =   true,
  $package_provider     =   'archive',
  $version              =   '7.0.50',
  $archive_source_uri   =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $archive_download_dir =   '/usr/local/src',
  $archive_target_dir   =   undef,
  $manage_user          =   true,
  $tomcat_user          =   'tomcat',
  $manage_group         =   true,
  $tomcat_group         =   'tomcat'
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

  if $package_provider == 'archive' {
    class { 'tomcat::install::archive':
      version              =>  $version,
      archive_source_uri   =>  $archive_source_uri,
      archive_download_dir =>  $archive_download_dir,
      archive_target_dir   =>  $archive_target_dir,
      manage_user          =>  $manage_user,
      tomcat_user          =>  $tomcat_user,
      manage_group         =>  $manage_group,
      tomcat_group         =>  $tomcat_group
    }
  }

}