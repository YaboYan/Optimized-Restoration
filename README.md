# What's this
Some people who have developed project about software defined network and Open vSwitchd may find that openflow messages can still be transmitted to the switches after all the ports have been shut down under in-band control scenario. This program solved this problem by sending the openflow messages to kernel space to transmit along with other data plane packets. Switches can match these packages from all the data running in the network and send them back to userspace where they are going to be handled.

# How to use

In order to run this program properly, you must follow the rules described bellow:

1.Switch 's1' is a special switch to this program. If you want to create an in-band topo. this switch must exist and make sure it is directly connected to the controller. Besides, you have to make sure that you create this switch before others by modifying the Mininet configuation file or add it manually. 

2.After you created your topo. You need to insert flow table manually for control messages to be transmitted. this program allocated one ip address for each switch, you can find these addresses at log files. Switch 's1' has ip address '10.0.0.124'. 

3.When you insert the flow table properly, you can start your controller to identify all switches.

4.After all these steps you can start you own project on it. If you have any problems, you can contact me by email (yaboyan@163.com).

I run my program under linux with mininet. I use RYU as my controller.

If you don't know how to replace your old OpenVswitch, you can try fresh.sh.

# test file 
I put test file in 'demo' folder. You can try them first. 
