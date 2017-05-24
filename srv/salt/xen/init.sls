# Install the Xen hypervisor and libvirt so it can be managed by salt-virt / terraform.
# Obviously, the hypervisor will like be already installed when you run this state. Otherwise
# you'll have to reboot to activate it and some other states may fail.

xen-hypervisor:
    pkg.installed:
        - pkgs:
            - xen-hypervisor-4.8-amd64
            - xen-system-amd64
            - xen-tools
            - xen-utils-4.8
            - xen-utils-common
            - xenstore-utils
            - libxen-4.8
            - libxenstore3.0
            - ipxe-qemu
            - qemu-system
            - qemu-system-arm
            - qemu-system-common
            - qemu-system-mips
            - qemu-system-misc
            - qemu-system-ppc
            - qemu-system-sparc
            - qemu-system-x86


libvirt-xen:
    pkg.installed:
        - pkgs:
            - libvirt-clients
            - libvirt-daemon
            - libvirt-daemon-system
            - libvirt0


xen-bridge-interfaces:
    file.managed:
        - name: /etc/network/interfaces.d/xenbridges
        - contents:
            # This file is generated by Salt
            auto xenbr0

            iface xenbr0 inet manual
                pre-up ip link add xenbr0 type bridge
                pre-up ip link add xbr0dummy0 type dummy
                pre-up ip link set xbr0dummy0 up
                pre-up ip link set xenbr0 up
                up ip link set xbr0dummy0 master xenbr0
                up ip addr add 10.0.1.1/24 dev xenbr0
                down ip link set xenbr0 down
                post-down ip link del xenbr0 type bridge
                post-down ip link del xbr0dummy0 type dummy

            auto {{pillar['ifassign']['external']}} xenbr1

            iface enp2s0 inet manual
                up ip link set enp2s0 up
                down ip link set enp2s0 down

            iface xenbr1 inet manual
                pre-up ip link add xenbr1 type bridge
                pre-up ip link set {{pillar['ifassign']['external']}} up
                pre-up ip link set xenbr1 up
                up ip link set dev {{pillar['ifassign']['external']}} master xenbr1
                up ip addr add {{pillar['network']['routed-ip']}}/32 peer {{pillar['network']['gateway']}} broadcast {{pillar['network']['routed-ip']}} dev xenbr1
            {% for additional_ip in pillar['network'].get('additional-ips', []) %}
                up ip route add {{additional_ip}}/32 dev xenbr1
            {% endfor %}
                up ip route add default via {{pillar['network']['gateway']}} dev xenbr1
                down ip link set xenbr1 down
                post-down ip link del xenbr1 type bridge


xen-forward-domUs:
    iptables.append:
        - table: filter
        - chain: FORWARD
        - jump: ACCEPT
        - source: 10.0.1.0/24
        - destination: 0/0
        - save: True
        - require:
            - sls: iptables


xen-nat-domUs:
    iptables.append:
        - table: nat
        - chain: POSTROUTING
        - jump: MASQUERADE
        - source: 10.0.1.0/24
        - destination: '! 10.0.1.0/24'
        - save: True
        - require:
            - sls: iptables
