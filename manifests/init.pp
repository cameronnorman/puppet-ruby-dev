class ruby_install {
  $username=$facts["id"]

  package { 'libgdbm-dev':
    ensure => installed,
  }

  package { 'libncurses5-dev':
    ensure => installed,
  }

  package { 'automake':
    ensure => installed,
  }

  package { 'libtool':
    ensure => installed,
  }

  package { 'bison':
    ensure => installed,
  }

  package { 'libffi-dev':
    ensure => installed,
  }

  package { 'g++':
    ensure => installed,
  }

  package { 'make':
    ensure => installed,
  }

  package { 'zlib1g-dev':
    ensure => installed,
  }

  package { 'libyaml-dev':
    ensure => installed,
  }

  package { 'libsqlite3-dev':
    ensure => installed,
  }

  package { 'sqlite3':
    ensure => installed,
  }

  package { 'pkg-config':
    ensure => installed,
  }

  package { 'libgmp-dev':
    ensure => installed,
  }

  package { 'libreadline6-dev':
    ensure => installed,
  }

  package { 'libssl-dev':
    ensure => installed,
  }

  file { "/home/${username}/.ssh":
    ensure    => 'directory',
    owner     => "${username}",
    group     => "${username}"
  }

  exec { 'generate_ssh_key':
    command   => "/bin/bash -c 'ssh-keygen -t rsa -f /home/${username}/.ssh/id_rsa -q -N \"\"'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    creates   => "/home/${username}/.ssh/id_rsa.pub",
    user      => "${username}",
    require   => File["/home/${username}/.ssh"]
  }

  rvm::ruby { "dev_ruby":
    user => $username,
    version => "ruby-2.4.0"
  }

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.6',
  }

  # class { 'postgresql::server': }

  # Can be used to create a database for your application

  # postgresql::server::db { 'mydatabasename':
  #   user     => 'mydatabaseuser',
  #   password => postgresql_password('mydatabaseuser', 'mypassword'),
  # }

  # postgresql::server::pg_hba_rule { 'access for local rails projects':
  #   type        => 'host',
  #   user        => 'all',
  #   database    => 'all',
  #   address     => '127.0.0.1/32',
  #   auth_method => 'trust',
  #   order       => 001,
  # }

  # postgresql::server::pg_hba_rule { 'access locally':
  #   type        => 'local',
  #   user        => 'all',
  #   database    => 'all',
  #   auth_method => 'trust',
  #   order       => 000,
  # }

  # include ::redis

  # service { 'redis':
  #   ensure => running,
  #   enable => true,
  # }

  # class { 'ohmyzsh': }

  # ohmyzsh::install { "${username}": }

  # ohmyzsh::theme { "${username}":
  #   theme => 'robbyrussell'
  # }

  # ohmyzsh::plugins { "${username}":
  #   plugins => 'git github ruby rails'
  # }
}
  # package { 'iptables-persistent':
  #   ensure => 'present'
  # }

  # resources { "firewall":
  #   purge   => true
  # }

  # class { ['my_fw::pre']: }

# class my_fw::pre {
#   Firewall {
#     require => undef,
#   }

#   firewall { "000 accept all icmp":
#     chain    => 'INPUT',
#     proto    => 'icmp',
#     action   => 'accept',
#   }

#   firewall { "001 accept all http":
#     chain    => 'INPUT',
#     proto    => 'tcp',
#     dport    => '80',
#     action   => 'accept',
#   }

#   firewall { "003 accept all icmp":
#     chain    => 'INPUT',
#     proto    => 'tcp',
#     action   => 'accept',
#     dport    => '22'
#   }
# }

include ruby_install
