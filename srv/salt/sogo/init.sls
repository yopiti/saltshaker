
sogo:
    pkgrepo.managed:
        - humanname: SOGo V3 Debian
        - name: {{pillar["repos"]["sogo"]}}
        - file: /etc/apt/sources.list.d/sogo.list
        - key_url: salt://sogo/sogo_810273C4.pgp.key
        - require_in:
            - pkg: sogo
    pkg.installed:
        - name: sogo
#        - require:
#            - file: sogo.preferences
    service.running:
        - enable: True
        - sig: /usr/sbin/sogod
        - require:
            - pkg: sogo


# commented out until version 3 hits Debian Stable
#sogo.preferences:
#    file.managed:
#        - name: /etc/apt/preferences.d/sogo
#        - source: salt://sogo/preferences.d/sogo

# vim: syntax=yaml
