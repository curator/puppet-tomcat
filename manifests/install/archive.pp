# Class: tomcat::install::archive
#
#
class tomcat::install::archive (
  $tar_source_uri   =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $version          =   '7.0.50',
  $tar_download_dir =   '/usr/local/src'
  ) {

  class { '::staging':
    path  => $tar_download_dir,
    owner => 'puppet',
    group => 'puppet'
  }

  staging::file { "apache-tomcat-${version}":
    source  => $tar_source_uri,
    require => Class['staging-tomcat']
  }

  $basename = inline_template('<%= File.basename(@tar_source_uri) %>')
  $dirname  = inline_template("<%= @basename.split('.').first %>")
  staging::extract { $basename:
    target  => $tar_download_dir,
    creates => "${tar_download_dir}/${dirname}",
    require => Staging::File["apache-tomcat-${version}"],
  }

  # Relationships
  Class['::staging']                      -> Staging::File["apache-tomcat-$version"]
  Staging::File["apache-tomcat-$version"] -> Staging::Extract[$basename]
}

