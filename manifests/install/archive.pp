# Class: tomcat::install::archive
#
#
class tomcat::install::archive (
  $package_name           =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $version                =   '7.0.50',
  $archive_download_dir   =   '/usr/local/src',
  $archive_target_dir     =   undef,
  $manage_user            =   true,
  $tomcat_user            =   'tomcat',
  $manage_group           =   true,
  $tomcat_group           =   'tomcat',
  $remove_default_apps    =   true,
  $remove_default_manager =   true,
  ) {

  # XXX Bleh way to default to /usr/share/tomcat${tomcat_maj_version} due to variable interpolation issues
  $tomcat_maj_version = regsubst($version, '^([0-9]+)[.].*$', '\1')
  if ! $archive_target_dir {
    $target_dir = "/usr/share/tomcat${tomcat_maj_version}"
  } else {
    $target_dir = $archive_target_dir
  }

  if $manage_group {
    if ! defined(Group[$tomcat_group]) {
      group { $tomcat_group:
        ensure  => present,
        system  => true,
      }
    }
  }

  if $manage_user {
    if ! defined(User[$tomcat_user]) {
      user { $tomcat_user:
        ensure  => present,
        gid     => $tomcat_group,
        system  => true,
        before  => File[$target_dir]
      }
    }
  }

  archive { "apache-tomcat-${version}":
    ensure           => present,
    url              => $package_name,
    follow_redirects => true,
    extension        => 'tar.gz',
    checksum         => false,
    src_target       => $archive_download_dir,
    target           => $target_dir
  }


  # Remove the default tomcat apps?
  if $remove_default_apps {
    $default_apps = [
      "${target_dir}/webapps/docs",
      "${target_dir}/webapps/examples",
      "${target_dir}/webapps/ROOT",
    ]
    file { $default_apps:
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true,
      require => Archive["apache-tomcat-${version}"]
    }
  }

  # Remove the default manager app?
  if $remove_default_manager {
    $manager_apps = [
      "${target_dir}/webapps/manager",
      "${target_dir}/webapps/host-manager"
    ]
    file { $manager_apps:
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true,
      require => Archive["apache-tomcat-${version}"]
    }
  }

  # Chown files in $target_dir
  file { $target_dir:
    ensure    => directory,
    owner     => $tomcat_user,
    group     => $tomcat_group,
    recurse   => true
  }

  # Symlink to a moderately standard/
  file { "/usr/bin/dtomcat${tomcat_maj_version}":
    ensure  => link,
    target  => "${target_dir}/bin/catalina.sh"
  }

  # Relationships
  Group[$tomcat_group]                -> User[$tomcat_user]
  User[$tomcat_user]                  -> Archive["apache-tomcat-${version}"]
  Archive["apache-tomcat-${version}"] -> File[$target_dir]
}

