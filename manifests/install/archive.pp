# Class: tomcat::install::archive
#
#
class tomcat::install::archive (
  $archive_source_uri   =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $version              =   '7.0.50',
  $archive_download_dir =   '/usr/local/src',
  $archive_target_dir   =   undef,
  $manage_user          =   true,
  $tomcat_user          =   'tomcat',
  $manage_group         =   true,
  $tomcat_group         =   'tomcat'
  ) {

  # XXX Bleh way to default to /usr/share/tomcat${tomcat_maj_version} due to variable interpolation issues
  $tomcat_maj_version = regsubst($version, '^([0-9]+[.]).*$', '\1')
  if ! $archive_target_dir {
    $target_dir = "/usr/share/tomcat${tomcat_maj_version}"
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

  if $manage_group {
    if ! defined(Group[$tomcat_group]) {
      group { $tomcat_group:
        ensure  => present,
      }
    }
  }

  if $manage_user {
    if ! defined(User[$tomcat_user]) {
      user { $tomcat_user:
        ensure  => present,
        gid     => $tomcat_group,
      }
    }
  }


  # Relationships
  Group[$tomcat_group] -> User[$tomcat_user]

}

