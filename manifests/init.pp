class rvm {
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
    user      => "${username}"
  }

  exec { 'get_gpg_key':
    command   => "/bin/bash -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => "/home/${username}",
    unless    => 'gpg --list-keys 409B6B1796C275462A1703113804BB82D39DC0E3',
    user      => "${username}"
  }

  exec { 'download_rvm':
    command   => "/bin/bash -c 'curl -sSL https://get.rvm.io >> /home/${username}/rvm_install.sh && chmod +x /home/${username}/rvm_install.sh'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => "/home/${username}",
    user      => "${username}",
    require   => Exec['get_gpg_key']
  }

  exec { 'install_rvm':
    command   => "/bin/bash -c 'source /home/${username}/rvm_install.sh'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => "/home/${username}"
  }

  exec { 'create_version_file':
    command   => "/bin/bash -c 'touch /usr/local/rvm/scripts/version'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => "/home/${username}"
  }

  exec { 'install_ruby':
    command   => "/bin/bash -c 'source /usr/local/rvm/scripts/rvm && rvm install 2.4.0 && rvm use 2.4.0 --default'",
    path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd       => "/home/${username}",
    timeout   => 0,
    require   => Exec['install_rvm']
  }

  class { 'postgresql::server': }

  # Can be used to create a database for your application

  # postgresql::server::db { 'mydatabasename':
  #   user     => 'mydatabaseuser',
  #   password => postgresql_password('mydatabaseuser', 'mypassword'),
  # }

  postgresql::server::pg_hba_rule { 'access for local rails projects':
    type        => 'host',
    user        => 'all',
    database    => 'all',
    address     => '127.0.0.1/32',
    auth_method => 'trust',
    order       => 001,
  }

  postgresql::server::pg_hba_rule { 'access locally':
    type        => 'local',
    user        => 'all',
    database    => 'all',
    auth_method => 'trust',
    order       => 000,
  }

  include ::redis

  service { 'redis':
    ensure => running,
    enable => true,
  }

  class { 'ohmyzsh': }

  ohmyzsh::install { 'cam': }

  ohmyzsh::theme { 'cam':
    theme => 'robbyrussell'
  }

  ohmyzsh::plugins { 'cam':
    plugins => 'git github ruby rails'
  }
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

include rvm
