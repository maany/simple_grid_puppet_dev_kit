#!/bin/bash
rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y --disablerepo=cern,el7,epel install puppetserver puppet-agent puppet-bolt 
yum -y install openssh-server openssh-clients vim-enhanced nfs-utils

systemctl disable firewalld
systemctl stop firewalld
setenforce 0

echo "/etc/puppetlabs/code/environments/production/modules/simple_grid/    <DEV-MACHINE-IP-ADDRESS>(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports
echo "************************* "
echo " Basic packages installed "
echo "************************* "

echo "Copying puppet server config"
cp /root/basic_config_master/data/puppetserver /etc/sysconfig/puppetserver

echo "Copying bolt config files to root"
cp -r /root/basic_config_master/data/.puppetlabs /root/

echo " Installing modules for Production environment (Install stage for Config Master)"
/opt/puppetlabs/bin/puppet module install puppet-r10k --version 6.7.0 --debug
#/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 5.0.0
/opt/puppetlabs/bin/puppet module install puppetlabs-docker  --version 2.0.0
/opt/puppetlabs/bin/puppet module install puppetlabs-git --version 0.5.0
/opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo --version 2.4.0
/opt/puppetlabs/bin/puppet module install puppet-python --version 2.1.1
/opt/puppetlabs/bin/puppet module install stahnma-epel --version 1.3.1
/opt/puppetlabs/bin/puppet module install puppet-ssh_keygen --version 3.0.1

echo "Installing puppet module..."
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid

echo "Creating dummy scripts..."
mkdir -p /etc/simple_grid/lifecycle
touch /etc/simple_grid/lifecycle/wn_pre_config.sh
touch /etc/simple_grid/lifecycle/wn_pre_inst1.sh
touch /etc/simple_grid/lifecycle/wn_post_inst1.sh
touch /etc/simple_grid/lifecycle/ce_pre_config.sh
touch /etc/simple_grid/lifecycle/ce_pre_inst1.sh
touch /etc/simple_grid/lifecycle/ce_post_inst1.sh
echo ""
echo "*********************************"
echo " 1. Clone your Simple GRID module:"
echo "*********************************"
echo "git clone https://github.com/<GIT-USERNAME>/simple_grid_puppet_module /etc/puppetlabs/code/environments/production/modules/simple_grid/"
echo ""
echo "*********************************"
echo " Edit /etc/exports with your development machine ip address"
echo "*********************************"
echo " vim /etc/exports"
echo ""
echo "*********************************"
echo " Restart NFS service"
echo "*********************************"
echo ""
echo " systemctl restart nfs-server "
echo ""
echo "*********************************"
echo "To mount in your dev machine: sudo mount -t nfs -o  resvport,rw <CM-MACHINE_IP_ADDRESS>:/etc/puppetlabs/code/environments/production/modules/simple_grid/ <˜YOUR-USER/DIR/>" 
echo ""
echo " To run VsCode from your Mac:"
echo ""
echo " sudo /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
echo ""