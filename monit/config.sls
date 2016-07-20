# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "monit/map.jinja" import monit with context %}

{%- set monitdict = monit['configu'] %}
{%- set monitconfigs = monit['config_files'] %}

{% for directory in monitdict  %}
{{ directory }}:
   file.directory
{% endfor %}

{% for conf_filename,conf_filepath in monitconfigs.items() %}
{{ conf_filename }}:
  file.managed:
    - name: {{ conf_filepath }}
    - source: salt://monit/files/{{ conf_filename }}.jinja
    - mode: 700
    - user: root
    - group: root
    - template: jinja
{% endfor %}
