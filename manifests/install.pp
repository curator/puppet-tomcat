# Class: tomcat::install
#
#
class tomcat::install inherits tomcat::params {

  if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
    notice('Yay! we can do stuff')
  } elsif $::osfamily == 'debian' {
    warning('Debian/Ubuntu support may be coming soon.  Feel free to add it.')
  } else {
    warning("Unsupported osfamily ${::osfamily}.")
  }

}