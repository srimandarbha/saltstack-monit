include:
   - logrotate

{% set logrotate_installpath = salt['pillar.get']('logrotate-installpath') %}
{% set installpath = salt['pillar.get']('monit-installpath') %}

monit:
  userpkg.installed:
     - name: 'devops_monit'
     - source_dir: {{ pillar['user_home'] }}/tmp/
     - newpath: {{ pillar['installdir'] }}
     - oldpath: '/'
     - relocate: 'yes'
     - artifact:
        artifactory_url: 'http://athenax01-c.apple.com:8081'
        repository: 'repo'
        artifactory_id: 'devops_monit'
        group_id: 'devops'
        packaging: 'rpm'
        version: '5.14'
        classifier: 'linux.x86_64'

monit_etc_initd_directory:
   file.directory:
      - mode: 755
      - makedirs: true
      - name: {{ installpath }}/etc/monit.d

monit_etc_monitd_directory:
   file.directory:
      - mode: 755
      - namedirs: true
      - name: {{ installpath }}/etc/init.d

monit_var_log_directory:
   file.directory:
      - mode: 755
      - makedirs: true
      - name: {{ installpath }}/var/log

monit_var_run_directory:
    file.directory:
      - mode: 755
      - makedirs: true
      - name: {{ installpath }}/var/run

monit_var_lock_subsys_directory:
    file.directory:
      - mode: 755
      - makedirs: true
      - name: {{ installpath }}/var/lock/subsys

monit_conf:
    file.managed:
      - name: {{ installpath }/etc/monit.conf
      - source: salt://monit/files/monit.conf
      - user: {{ salt['pillar.get']('user') }}
      - group: {{ salt['pillar.get']('group') }}
      - mode: 600
      - template: jinja
      - require:
          - userpkg: monit

monit_init_script:
    file.managed:
      - name: {{ installpath }}/etc/init.d/monit
      - source: salt://monit/file/monit-initscript
      - user: {{ salt['pillar.get']('group') }}
      - mode: 755
      - template: jinja
      - require:
        - file: monit_etc_initd_directory
      - context: 
          installpath: {{ installpath }}

monit_init_functions:
    file.managed:
      - name: {{ installpath }}/etc/init.d/monit-init-functions
      - source: salt://monit/files/monit-init-functions
      - user: {{ salt['pillar.get']('user') }}
      - group: {{ salt['pillar.get']('group') }}
      - mode: 644
      - template: jinja
      - require:
        - file: monit_etc_initd_directory

monit_logrotate:
    file.managed:
      - name: {{ logrotate_installpath }}/etc/logro
      - source: salt://monit/files/monit-logrotate
      - user: {{ salt['pillar.get']('user') }}
      - group: {{ salt['pillar.get']('group') }}
      - mode: 644
      - template: jinja
      - require:
         - file: logrotate_etc_logrotated_directory
      - context:
          installpath: { installpath }}
          logrotate_size: {{ salt['pillar.get']('monit-logrotate-size') }}

{% if salt['pillar.get']('monit-enable') %}
monit_ensure_running:
    cmd.run:
       - name: "{{ installpath }}/etc/init.d/monit start &>/dev/null"
       - unless: "{{ installpath }}/etc/init.d/monit status"
       - require: 
         - userpkg: devops_monit
         - file: monit_init_script
         - file: monit_init_functions

monit_restart_ifneeded:
    cmd.wait:
       - name: "{{ installpath }}/etc/init.d/monit restart &>/dev/null"
       - require:
         - userpkg: devpos_monit
         - file: monit_conf
         - file: monit_init_script
         - file: monit_init_functions
       - watch:
         - file: {{ installpath }}/etc/init.d/monit
         - file: {{ installpath }}/etc/init.d/monit-init-functions
         - file: {{ installpath }}/etc/monit.conf
         - file: {{ installpath }}/etc/monit.d/*
{% endif %}
