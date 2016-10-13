{% from 'shared/ssl.sls' import certificate_location, secret_key_location %}

postgresql:
    sslcert: {{salt['file.join'](certificate_location, 'postgresql.crt')}}
    sslkey: {{salt['file.join'](secret_key_location, 'postgresql.key')}}

    hbafile: /etc/postgresql/9.6/main/pg_hba.conf


# vim: syntax=yaml
