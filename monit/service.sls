# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

monit-name:
  service.running:
    - name: {{ monit.service.name }}
    - enable: True
    - onchanges:
      - file: {{ monit.config }}
