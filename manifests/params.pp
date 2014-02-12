# Class: tomcat::params
#
#
class tomcat::params {

  if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {

    $install_java = true

  } elsif $::osfamily == 'debian' {
    fail('Debian/Ubuntu support may be coming soon.  Feel free to add it.')
  } else {
    fail("Unsupported osfamily ${::osfamily}.")
  }

}