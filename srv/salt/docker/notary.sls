
{% set notary_user = "notary" %}
{% set notary_group = "notary" %}


notary-config-folder:
    file.directory:
        - name: /etc/notary
        - user: root
        - group: root
        - mode: '0755'
        - makedirs: True
        - require:
            - user: {{notary_user}}


notary:
    group.present:
        - name: {{notary_group}}
    user.present:
        - name: {{notary_user}}
        - gid: {{notary_group}}
        - createhome: False
        - home: /etc/notary
        - shell: /bin/false
        - require:
            - group: notary
    file.managed:
        - name: /usr/local/bin/nomad_linux_amd64
        - source: {{pillar["urls"]["notary"]}}
        - source_hash: {{pillar["hashes"]["notary"]}}
        - mode: '0755'
        - user: {{notary_user}}
        - group: {{notary_group}}
        - replace: False
        - require:
            - user: notary-config-folder


notary-config:
    file.managed:
        - name: /etc/notary/notary.conf.json
        - source: salt://docker/notary.jinja.conf.json
        - user: {{notary_user}}
        - group: {{notary_group}}
        - mode: '0640'
        - template: jinja
        - context:
            ip: {{ip}}
            port: {{port}}
        - require:
            - file: notary


notary-service:
    file.managed:
        - name: /etc/systemd/system/notary.service
        - source: salt://docker/notary.jinja.service
        - user: root
        - group: root
        - mode: '0644'
        - template: jinja
        - context:
            user: {{notary_user}}
            group: {{notary_group}}
    service.running:
        - name: notary
        - sig: notary_linux_amd64
        - enable: True
        - watch:
            - file: notary-config
            - file: notary-service
            - file: notary


notary-servicedef:
    file.managed:
        - name: /etc/consul/services.d/notary.json
        - source: salt://docker/consul/notary.jinja.json
        - user: root
        - group: root
        - mode: '0644'
        - template: jinja
        - context:
            ip: {{ip}}
            port: {{port}}
