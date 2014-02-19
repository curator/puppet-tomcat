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
  $install_java           =   true,
  $package_provider       =   undef,
  $version                =   '7.0.50',
  $archive_source_uri     =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $archive_download_dir   =   '/usr/local/src',
  $archive_target_dir     =   undef,
  $manage_user            =   true,
  $tomcat_user            =   'tomcat',
  $manage_group           =   true,
  $tomcat_group           =   'tomcat',
  $remove_default_apps    =   true,
  $remove_default_manager =   true
  ) inherits tomcat::params {

  class { 'tomcat::install':
    install_java           => $install_java,
    package_provider       => $package_provider,
    version                => $version,
    archive_source_uri     => $archive_source_uri,
    archive_download_dir   => $archive_download_dir,
    archive_target_dir     => $archive_target_dir,
    manage_user            => $manage_user,
    tomcat_user            => $tomcat_user,
    manage_group           => $manage_group,
    tomcat_group           => $tomcat_group,
    remove_default_apps    => $remove_default_apps,
    remove_default_manager => $remove_default_manager
  }

}
