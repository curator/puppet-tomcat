# Class: tomcat::config
#
#
class tomcat::config (
  $java_home    = undef,
  $java_opts    = undef,
  $path         = undef,
  $setenv_path  = undef,
  $tomcat_user  = 'tomcat',
  $tomcat_group = 'tomcat',
  $service_name = undef
  ) {

  if $java_opts {
    if is_array($java_opts) {
      $java_opts_string = join(flatten($java_opts), ' ')
    } elsif is_string($java_opts) {
      $java_opts_string = $java_opts
    }
  }

  file {
    $setenv_path:
      ensure  => file,
      owner   => $tomcat_user,
      group   => $tomcat_group,
      content => template('tomcat/setenv.sh.erb'),
      mode    => '0555'
  }

  if $service_name {
    if defined(Service[$service_name]) {
      File[$setenv_path] ~> Service[$service_name]
    }
  }
}