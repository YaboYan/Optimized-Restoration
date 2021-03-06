#!/bin/sh
#remove the old ovs
ovs-dpctl del-dp ovs-system
kill `cd /usr/local/var/run/openvswitch && cat ovsdb-server.pid ovs-vswitchd.pid`
aptitude remove openvswitch-common openvswitch-datapath-dkms openvswitch-controller openvswitch-pki openvswitch-switch -y
rmmod openvswitch
#install the new ovs
cd （your path to ovs）
rm datapath/linux/openvswitch.ko
./boot.sh
./configure  --with-linux=/lib/modules/`uname -r`/build --enable-coverage
make 
make install 
modprobe gre
#insmod datapath/linux/openvswitch.ko
make modules_install
/sbin/modprobe openvswitch
#disable openvswitch controller
/etc/init.d/openvswitch-controller stop
update-rc.d openvswitch-controller disable
#start the new ovs
rm -r /usr/local/etc/openvswitch
mkdir -p /usr/local/etc/openvswitch
ovsdb-tool create /usr/local/etc/openvswitch/conf.db vswitchd/vswitch.ovsschema
ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock --remote=db:Open_vSwitch,Open_vSwitch,manager_options --pidfile --detach --log-file
/etc/init.d/openvswitch-switch start
ovs-vsctl --no-wait init
ovs-vswitchd --pidfile --detach
