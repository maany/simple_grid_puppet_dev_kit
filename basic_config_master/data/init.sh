#!/bin/bash
cp /data/puppetserver /etc/sysconfig/puppetserver

hostnamectl set-hostname basic_config_master.cern.ch
hostnamectl set-hostname basic_config_master.cern.ch

#echo "Building puppet module"
#puppet module build /simple_grid

echo "Installing puppet module"
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid

echo "Creating dummy scripts"
mkdir -p /etc/simple_grid/lifecycle
touch /etc/simple_grid/lifecycle/wn_pre_config.sh
touch /etc/simple_grid/lifecycle/wn_pre_inst1.sh
touch /etc/simple_grid/lifecycle/wn_post_inst1.sh
touch /etc/simple_grid/lifecycle/ce_pre_config.sh
touch /etc/simple_grid/lifecycle/ce_pre_inst1.sh
touch /etc/simple_grid/lifecycle/ce_post_inst1.sh
echo "All Set for development"