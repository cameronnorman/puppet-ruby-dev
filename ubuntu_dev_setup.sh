sudo apt-get -y update
sudo apt-get -y install git puppet librarian-puppet

git clone https://github.com/cameronnorman/puppet-ruby-dev.git
sudo mkdir -p /etc/puppet/code/modules
cd puppet-ruby-dev
sudo librarian-puppet install --path /etc/puppet/code/modules
sudo puppet apply manifests/init.pp --verbose
