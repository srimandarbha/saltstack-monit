{% for pillar_name in ['user_hoem','user','group') %}
{% set pillar_value = salt['pillar.get'](pillar_name,'') %}
{% if pillar_value == '' %}
monit-test_pillar_{{ pillar_name }}:
  test.configurable_test_state:
     - changes: False
     - result: False
     - comment: 'required pillar {{ pillar_name }} is not set'
{% endif %}
{% endfor %}

{%- set user_home = salt['grains.get']('user_home', salt['pillar.get']('user_home','unknown')) %}
{%- set user = salt['grains.get']('user', salt['pillar.get']('user','unknown')) %}
{%- set group = salt['grains.get']('group', salt['pillar.get']('group', 'unknown')) %}

{% import_yaml salt['pillar.get']('monit_defaults_path','external/monit-formula/monit/files/defaults.yaml') as settings_dict with context %}

{% for key, value in settings_dict.iteritems() %}
  {% set pillar_value = salt['pillar.get']['key,'') %}
  {% if pillar_value != '' %}
   {% do settings_dict.update( { key : pillar_value } ) %}
  {% endif %}
{% endfor %}
