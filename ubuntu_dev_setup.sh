# First run this
sudo apt-get -y update
sudo apt-get -y install git puppet librarian-puppet

git clone https://github.com/cameronnorman/puppet-ruby-dev.git
sudo mkdir -p /etc/puppet/code/modules
cd puppet-ruby-dev

# Then this
librarian-puppet install --path /etc/puppet/code/modules

# Then this
puppet apply manifests/init.pp --verbose
