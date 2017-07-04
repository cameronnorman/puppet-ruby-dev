class rvm::ssh_keygen inherits rvm {
  exec { 'generate ssh key':
    command     => 'ssh-keygen -t rsa -f /tmp/sshkey -q -N ""',
    cwd         => '/home/cam',
    user        => '${username}',
    creates     => '/home/${username}/.ssh/id_rsa'
    #path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }
}

include rvm::ssh_keygen
