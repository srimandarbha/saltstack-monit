# -*- coding: utf-8 -*-
# vim: ft=yaml
monit:
  pkg: monit
  pkgname: 'monit.rpm'
  pkgpath: '/usr/bin/monit' 
  monit-install: '/'
  config: '/etc/monit/monitrc'
  logrotate: monit-logrotate.jinja
  initscript: monit-init.jinja
  service:
    name: monit
  configu:
      - '/etc/monit'
      - '/etc/monit/conf.d'
      - '/var/log/monit'
  checks:
      host1: { 'address': '54.169.170.122', 'port': 80, 'service': 'http' }
      host2: { 'address': 'scanme.nmap.org', 'port': 80, 'timeout': 15, 'service': 'http' }
      host3: { 'address': 'www.greatandhra.com', 'port': 80, 'timeout': 20, 'service': 'http'}
  config_files: 
     monit_init: '/etc/init.d/monit'
     monit_logrotate: '/etc/logrotate.d/monit'
     monit_config: '/etc/monit/monitrc'
     customchecks: '/etc/monit/conf.d/customchecks'
