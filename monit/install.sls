# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

{% for directory in salt['pillar.get']('monit:configu',[]) %}
{{ directory }}:
   file.directory
{% endfor %}

monit-pkg:
  file.managed:
    - name: '/tmp/{{ monit.pkgname }}'
    - source: salt://monit/files/{{ monit.pkgname }}
    - mode: 755

monit-install:
  cmd.run:
    - name: rpm -i {{ monit.pkgname }}
    - cwd: /tmp
    - creates: {{ monit.pkgpath }}
