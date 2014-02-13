# Class: tomcat::install::archive
#
#
class tomcat::install::archive (
  $archive_source_uri   =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $version              =   '7.0.50',
  $archive_download_dir =   '/usr/local/src',
  $archive_target_dir   =   undef
  ) {

  # Bleh way to default to /opt/tomcat${tomcat_maj_version} due to variable interpolation issues
  $tomcat_version_bits = split($version,'[.]')
  $tomcat_maj_version = $tomcat_version_bits[0]
  if ! $archive_target_dir {
    $target_dir = "/opt/tomcat${tomcat_maj_version}"
  } else {
    $target_dir = $archive_target_dir
  }

  archive { "apache-tomcat-${version}":
    ensure           => present,
    url              => $archive_source_uri,
    follow_redirects => true,
    extension        => 'tar.gz',
    src_target       => $archive_download_dir,
    target           => $archive_target_dir
  }

}

