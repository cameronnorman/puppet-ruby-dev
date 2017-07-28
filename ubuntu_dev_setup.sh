# First run this
sudo apt-get -y install git puppet librarian-puppet
git clone https://github.com/cameronnorman/puppet-ruby-dev.git
sudo mkdir -p /etc/puppet/code/modules
cd puppet-ruby-dev

# Then this
username=$(whoami)
sudo chown -R $username:$username /etc/puppet
sudo librarian-puppet install --path /etc/puppet/code/modules --verbose

# Then this
sudo puppet apply manifests/init.pp --verbose
