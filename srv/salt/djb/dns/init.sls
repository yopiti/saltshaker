
include:
    - djb

djbdns-install-directory:
    file.exists:
        - name: /usr/local/djbdns-1.05
        - require:
            - cmd: djbdns-install


djbdns-version-symlink:
    file.symlink:
        - name: /usr/local/djbdns
        - target: /usr/local/djbdns-1.05
        - require:
            - file: djbdns-install-directory


djbdns-source-archive:
    file.managed:
        - name: /usr/local/src/djb/djbdns-1.05.tar.gz
        - source: {{pillar["urls"]["djbdns"]}}
        - source_hash: sha256=3ccd826a02f3cde39be088e1fc6aed9fd57756b8f970de5dc99fcd2d92536b48
        - require:
            - file: djb-source-build-directory


djbdns-install:
    cmd.script:
        - source: salt://djb/dns/install.sh
        - cwd: /usr/local/src/djb
        - user: root
        - group: root
        - require:
            - file: djbdns-source-archive
            - pkg: build-essential
            - pkg: make
            - pkg: ucspi-tcp
            - pkg: daemontools
        - unless: test -e /usr/local/djbdns-1.05


dns-group:
    group.present:
         - name: dns

dns:
    user.present:
        - gid: dns
        - home: /etc/tinydns-internal
        - createhome: False
        - shell: /bin/false
        - require:
            - group: dns-group


dnslog:
    user.present:
        - gid: dns
        - home: /etc/tinydns-internal
        - createhome: False
        - shell: /bin/false
        - require:
            - group: dns-group


tinydns-install:
    cmd.run:
        - name: /usr/local/djbdns/bin/tinydns-conf dns dnslog /etc/tinydns-internal 127.0.0.1
        - require:
            - file: djbdns-version-symlink
            - user: dns
            - user: dnslog
        - unless: test -e /etc/tinydns-internal


tinydns-data:
    file.managed:
        - name: /etc/tinydns-internal/root/data
        - source: salt://djb/dns/data
        - template: jinja
        - require:
            - cmd: tinydns-install


dnscache-install:
    cmd.run:
        - name: /usr/local/djbdns/bin/dnscache-conf dns dnslog /etc/dnscache {{pillar['dns-internal']['ip']}}
        - require:
            - file: djbdns-version-symlink
            - user: dns
            - user: dnslog
        - unless: test -e /etc/dnscache


dnscache-config:
    file.managed:
        - name: /etc/dnscache/root/servers/internal
        - source: salt://djb/dns/internal
        - require:
            - cmd: dnscache-install

# -* vim: syntax=yaml

