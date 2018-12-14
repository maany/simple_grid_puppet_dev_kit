FROM cern/cc7-base
LABEL Maintainer="Mayank Sharma (imptodefeat@gmail.com)"
RUN rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
RUN yum -y --disablerepo=cern,el7,epel install puppetserver puppet-agent puppet-bolt 
RUN yum -y install openssh-server openssh-clients vim-enhanced iptables docker

# modules for Production environment (Install stage for Config Master. The module is mounted in init.sh)
RUN /opt/puppetlabs/bin/puppet module install puppet-r10k --version 6.7.0 --debug
#RUN /opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 5.0.0
#RUN /opt/puppetlabs/bin/puppet module install puppetlabs-docker --version 3.1.0
RUN /opt/puppetlabs/bin/puppet module install puppetlabs-git --version 0.5.0
RUN /opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo --version 2.4.0
RUN /opt/puppetlabs/bin/puppet module install puppet-python --version 2.1.1
RUN /opt/puppetlabs/bin/puppet module install stahnma-epel --version 1.3.1
RUN /opt/puppetlabs/bin/puppet module install puppet-ssh_keygen --version 3.0.1



VOLUME ["/etc/puppetlabs/code/environments/production/modules/simple_grid/"]

# Puppetserver config
RUN mkdir /data
VOLUME [ "/data" ]

# Puppetmodule mount point
RUN mkdir /simple_grid
VOLUME [ "/simple_grid" ]

# docker
VOLUME [ "/var/lib/docker" ]

#systemd
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]