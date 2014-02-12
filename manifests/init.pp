# == Class: tomcat
#
# Full description of class tomcat here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { tomcat:
#    install_java   => false,
#    tomcat_version => '7.0.50',
#    source         => 'http://peaches.me/tomcat/apache-tomcat-7.0.50.tar.gz'
#  }
#
# === Authors
#
# Preston Norvell <preston.norvell@gettyimages.com>
# Andrew Nelson   <andrew.nelson@gettyimages.com>
#
# === Copyright
#
# Copyright 2014 Getty Images, Inc.
#
class tomcat (
  $install_java   =   $tomcat::params::install_java,
  $tomcat_version =   $tomcat::params::tomcat_version,
  $java_home      =   $tomcat::params::java_home
  ) inherits tomcat::params {

  if $install_java {
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
}
