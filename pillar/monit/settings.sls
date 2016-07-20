# -*- coding: utf-8 -*-
# vim: ft=yaml
monit:
  pkg: monit
  pkgname: 'monit.rpm'
  pkgpath: '/usr/bin/monit' 
  config: '/etc/monit/monitrc'
  configu:
      - '/etc/monit'
      - '/etc/monit/conf.d'
      - '/var/log/monit'
  logrotate: monit-logrotate.jinja
  initscript: monit-init.jinja
  service:
    name: monit
