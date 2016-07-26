#stop monit

stop-monit:
   cmd.run:
     - name: "ps -ef | grep {{ pillar['user_home'] }}/build/monit/conf/monitrc | grep -v grep | awk '{print $2}' | xargs kill"
     - onlyif: "ps -ef | grep {{ pillar['user_home'] }}/build/monit/conf/monitrc | grep -v grep"
