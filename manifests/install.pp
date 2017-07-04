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

  exec { 'generate ssh key':
    command     => "ssh-keygen -t rsa -f /home/${username}/.ssh -q -N '' && 0",
    #cwd         => '/home/cam',
    user        => '${username}',
    creates     => '/home/${username}/.ssh/id_rsa',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    returns     => [1]
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }

  exec { 'install ubuntu rvm':
    command      => "sh /home/${username}/puppet-ruby-dev/modules/rvm_ubuntu.sh",
    user        => '${username}',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    returns     => [1]
    #cwd         => '.',
    #creates     => '/file/created',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }
}

include install
