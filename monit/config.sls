# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

monit-config:
  file.managed:
    - name: {{ monit.config }}
    - source: salt://monit/files/monitrc.jinja
    - mode: 700
    - user: root
    - group: root
