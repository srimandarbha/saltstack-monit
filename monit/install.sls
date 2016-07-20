# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

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
