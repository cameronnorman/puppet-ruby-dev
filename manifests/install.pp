class rvm::install inherits rvm {
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
