class install {
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
    command     => 'ssh-keygen -t rsa -f /tmp/sshkey -q -N ""',
    cwd         => '/home/cam',
    user        => '${username}',
    creates     => '/home/${username}/.ssh/id_rsa'
    #path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }

  exec { 'install ubuntu rvm':
    command      => '../modules/rvm_ubuntu.sh',
    cwd         => '.',
    user        => '${username}',
    #path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #creates     => '/file/created',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }
}
