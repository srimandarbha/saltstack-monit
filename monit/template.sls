# -*- coding: utf-8 -*-
# vim: ft=sls


monit-customrc:
  file.managed:
    - name: '/etc/monit/conf.d/customchecks'
    - source: salt://monit/files/customchecks.jinja
    - mode: 700
    - user: root
    - group: root
    - template: jinja
