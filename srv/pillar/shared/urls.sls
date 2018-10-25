# This is a collection of URLs that different states use to download packages /
# archives / other things. They are here so that they can be easily overridden,
# for example in local.url_overrides for a local development file server/debian
# mirror if you have such a thing

repos:
    aptly: deb http://repo.aptly.info/ squeeze main
    aptly-nightly: deb http://repo.aptly.info/ nightly main
    docker: deb https://apt.dockerproject.org/repo debian-stretch main
    stretch: deb http://ftp-stud.hs-esslingen.de/debian/ stretch main contrib
    stretch-backports: deb http://ftp-stud.hs-esslingen.de/debian/ stretch-backports main
    stretch-security: deb http://security.debian.org/ stretch/updates main
    stretch-updates: deb http://ftp-stud.hs-esslingen.de/debian/ stretch-updates main
    maurusnet-apps: deb http://repo.maurus.net/release/stretch/ mn-release main
    maurusnet-opensmtpd: deb http://repo.maurus.net/stretch/opensmtpd/ mn-opensmtpd main
    maurusnet-radicale: deb http://repo.maurus.net/stretch/radicale/ mn-radicale main
    postgresql: deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main
    saltstack: deb http://repo.saltstack.com/apt/debian/9/amd64/latest stretch main
    haproxy: deb http://haproxy.debian.net stretch-backports-1.8 main

#   pgpkey: Set this to a salt:// url if you need to deploy your own repo signing key
#           If you need to deploy more than one key, you should really write your own
#           state for that!

urls:
    concourse: https://github.com/concourse/concourse/releases/download/v4.2.1/concourse_linux_amd64
    consul: https://releases.hashicorp.com/consul/1.3.0/consul_1.3.0_linux_amd64.zip
    consul-esm: https://releases.hashicorp.com/consul-esm/0.2.0/consul-esm_0.2.0_linux_amd64.zip
    consul-replicate: https://releases.hashicorp.com/consul-replicate/0.4.0/consul-replicate_0.4.0_linux_amd64.zip
    consul-template: https://releases.hashicorp.com/consul-template/0.19.5/consul-template_0.19.5_linux_amd64.zip
    exxo: https://bintray.com/artifact/download/mbachry/exxo/exxo-0.0.7.tar.xz
    nomad: https://releases.hashicorp.com/nomad/0.8.6/nomad_0.8.6_linux_amd64.zip
    pyrun35: https://downloads.egenix.com/python/egenix-pyrun-2.2.3-py3.5_ucs4-linux-x86_64.tgz
    terraform: https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
    vault: https://releases.hashicorp.com/vault/0.11.4/vault_0.11.4_linux_amd64.zip
    vault-gpg-plugin: https://github.com/LeSuisse/vault-gpg-plugin/releases/download/v0.2.1/linux_amd64.zip
    vault-ssh-helper: https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip


hashes:
    concourse: sha256=e3cada9e536af9596cfb812dc4af37cbc9ff7e4ed6f3d3ee91a6b62a6356d02a
    consul: sha256=a6896509b72fa229496b3adda51357c95d68a796ae3328d7d6a61195d6c68bac
    consul-esm: sha256=9a49a3c3d1b890ae738c73764354e36e4b13e90677b552f140f1033c1ae2a464
    consul-replicate: sha256=96c6651291c2f8e75d98d04b9b4653d8a02324edaa25783744d9ea1d8d411c61
    consul-template: sha256=e6b376701708b901b0548490e296739aedd1c19423c386eb0b01cfad152162af
    exxo: sha256=ce3d6ae10d364c5a0726cce127602fe6fa5d042b11afd21d79502f8216b42e1e
    nomad: sha256=7569561e4a8fdb283f36f9ff6ed7834be6b1f4a2149246f8bd3fb719265c800c
    pyrun35: sha256=8bf8b374f582bb53600dd846a0cdb38e18586bbda06261321d48df69ddbf730e
    terraform: sha256=84ccfb8e13b5fce63051294f787885b76a1fedef6bdbecf51c5e586c9e20c9b7
    vault: sha256=3e44826ffcf3756a72d6802d96ea244e605dad362ece27d5c8f8839fb69a7079
    vault-gpg-plugin: sha256=5de768840cc4c6d1b13128a707f85bec2f2af802e583a4c519cc3f7886fd76e6
    vault-gpg-plugin-binary: sha256=1a3cb5ef949ccea223df019b7dd7dd1de2af4ea4e2b14364790e90f6386e4911
    vault-ssh-helper: sha256=156ce8250725e64a3e4dc51018a18813dd44d1f2a6c853976bc20e1625d631a1
