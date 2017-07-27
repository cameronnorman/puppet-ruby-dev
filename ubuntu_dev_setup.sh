sudo apt-get -y update
sudo apt-get -y install git puppet

sudo apt-get install librarian-puppet
git clone https://github.com/cameronnorman/puppet-ruby-dev.git
sudo mkdir /etc/puppet/code/modules
cd puppet-ruby-dev
librarian-puppet install --path /etc/puppet/code/modules
sudo puppet apply manifests/init.pp --verbose
