sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm

rvm install 2.4.0

rvm use 2.4.0 --default

gem install bundler

git config --global color.ui true

ssh-keygen -t rsa -b 4096 -C "leonpaps@gmail.com"

git config --global user.name "Leon"

git config --global user.email "leonpaps@gmail.com"
