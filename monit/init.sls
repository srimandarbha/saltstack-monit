# -*- coding: utf-8 -*-
# vim: ft=sls


{% if salt['grains.get']('os_family') == 'RedHat' %}
include:
  - monit.install
  - monit.config
  - monit.service
{% endif %}
