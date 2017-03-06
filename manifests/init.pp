# == Class: openresty
#
# Full description of class openresty here.
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
#  class { 'openresty':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2017 Your name here, unless otherwise noted.
#

class openresty(
  $openresty_version='1.11.2.2'
)
{

  $package_dependency = $osfamily ? {
    'redhat' => ['pcre', 'pcre-devel', 'openssl', 'openssl-devel'],
    'debian' => ['libpcre3','libpcre3-dev', 'libssl-dev'],
    'default' => ['pcre','pcre-devel', 'openssl', 'openssl-devel'],
  }
  package { $package_dependency :
     ensure => installed,
  }

  exec {'download and untar openresty':
    cwd => '/tmp/',
    command => "wget https://openresty.org/download/openresty-${openresty_version}.tar.gz; tar -xvf openresty-${openresty_version}.tar.gz",
    creates => "/tmp/openresty-${openresty_version}.tar.gz",
    path    => ['/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
 }


  exec {'configure openresty':
   cwd => "/tmp/openresty-${openresty_version}",
   command => "/bin/bash -c cd /tmp/openresty-${openresty_version}; ./configure --with-pcre --with-pcre-jit --with-lua51 --with-luajit --with-http_ssl_module --without-http_rewrite_module;",
   path => ['/usr/bin/env','/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
   timeout => 0,
   logoutput => true,
   require => Package[$package_dependency]
 }


  exec {'install openresty':
   cwd => "/tmp/openresty-${openresty_version}",
   command => "/bin/bash -c cd /tmp/openresty-${openresty_version};make; make install",
   path => ['/usr/bin/env','/usr/bin', '/usr/sbin','/urs/local/sbin','/usr/local/bin','/bin','/sbin',],
   timeout => 0,
   logoutput => true,
 }

  Exec['download and untar openresty'] -> Exec['configure openresty']
  Exec['configure openresty'] -> Exec['install openresty']
}

