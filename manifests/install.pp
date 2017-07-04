class install {
  $username="cam"

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

  file { "/home/${username}/.ssh":
    ensure => 'directory',
    owner => "${username}",
    group => "${username}"
  }

  exec { 'generate ssh key':
    command     => "ssh-keygen -t rsa -f /home/${username}/.ssh/id_rsa -q -N ''",
    user        => '${username}',
    creates     => '/home/${username}/.ssh/id_rsa',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #cwd         => '/home/cam',
    #returns     => [1]
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }

  exec { 'install ubuntu rvm':
    command      => "bash /home/${username}/puppet-ruby-dev/modules/rvm_ubuntu.sh",
    user        => '${username}',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #returns     => [1]
    #cwd         => '.',
    #creates     => '/file/created',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }
}

include install
