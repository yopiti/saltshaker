
secure-base-dir:
    file.directory:
        - name: /secure/postgres
        - user: postgres
        - group: postgres
        - mode: '0750'
        - require:
            - secure-mount


secure-tablespace-dir:
    file.directory:
        - name: /secure/postgres/9.5/main
        - user: postgres
        - group: postgres
        - mode: '0750'
        - makedirs: True
        - require:
            - file: secure-base-dir


secure-tablespace:
    postgres_tablespace.present:
        - name: secure
        - directory: /secure/postgres/9.5/main
        - db_user: postgres
        - user: postgres
        - require:
            - data-cluster
            - secure-tablespace-dir


# vim: syntax=yaml
