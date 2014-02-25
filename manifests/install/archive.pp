# Class: tomcat::install::archive
#
#
class tomcat::install::archive (
  $package_name           =   'http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.50/bin/apache-tomcat-7.0.50.tar.gz',
  $version                =   '7.0.50',
  $archive_download_dir   =   '/usr/local/src',
  $archive_target_dir     =   '/usr/share',
  $manage_user            =   true,
  $tomcat_user            =   'tomcat',
  $manage_group           =   true,
  $tomcat_group           =   'tomcat',
  $remove_default_apps    =   true,
  $remove_default_manager =   true,
  $symlink_to_maj_version =   true
  ) {

  $tomcat_maj_version = regsubst($version, '^([0-9]+)[.].*$', '\1')
  $tomcat_expanded_dir = inline_template('<%= File.basename(@package_name,".tar.gz") %>')
  $tomcat_install_dir = "${archive_target_dir}/${tomcat_expanded_dir}"

  archive { "apache-tomcat-${version}":
    ensure           => present,
    url              => $package_name,
    follow_redirects => true,
    extension        => 'tar.gz',
    checksum         => false,
    src_target       => $archive_download_dir,
    target           => $archive_target_dir
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
        before  => File[$tomcat_install_dir]
      }
    }
  }


  # Remove the default tomcat apps?
  if $remove_default_apps {
    $default_apps = [
      "${tomcat_install_dir}/webapps/docs",
      "${tomcat_install_dir}/webapps/examples",
      "${tomcat_install_dir}/webapps/ROOT",
    ]
    file { $default_apps:
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true,
      require => Archive["apache-tomcat-${version}"],
      before  => File[$tomcat_install_dir]
    }
  }

  # Remove the default manager app?
  if $remove_default_manager {
    $manager_apps = [
      "${tomcat_install_dir}/webapps/manager",
      "${tomcat_install_dir}/webapps/host-manager"
    ]
    file { $manager_apps:
      ensure  => absent,
      recurse => true,
      purge   => true,
      force   => true,
      require => Archive["apache-tomcat-${version}"],
      before  => File[$tomcat_install_dir]
    }
  }

  # Chown files in $tomcat_install_dir
  file { $tomcat_install_dir:
    ensure    => directory,
    owner     => $tomcat_user,
    group     => $tomcat_group,
    recurse   => true
  }

  # Symlink to a moderately standard/location
  file { "/usr/bin/dtomcat${tomcat_maj_version}":
    ensure  => link,
    target  => "${tomcat_install_dir}/bin/catalina.sh"
  }

  if $symlink_to_maj_version {
    file { "${archive_target_dir}/tomcat${tomcat_maj_version}":
      ensure  => link,
      target  => $tomcat_install_dir,
      require => Archive["apache-tomcat-${version}"]
    }
  }

  # Symlink to a
  # Relationships
  Group[$tomcat_group]                -> User[$tomcat_user]
  User[$tomcat_user]                  -> Archive["apache-tomcat-${version}"]
  Archive["apache-tomcat-${version}"] -> File[$tomcat_install_dir]
  Archive["apache-tomcat-${version}"] -> File["/usr/bin/dtomcat${tomcat_maj_version}"]
}

