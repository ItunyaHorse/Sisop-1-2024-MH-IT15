#!/bin/bash

mem=$(free -m | awk 'NR==2 {print $2","$3","$4","$5","$6","$7}')
swap=$(free -m | awk 'NR==3 {print $2","$3","$4}')
waktu=$(date +"%Y%m%d%H%M%S")


echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_$waktu.log
echo "$mem,$swap,/home/mken,$(du -sh /home/mken | awk '{print $1}')" >> metrics_$waktu.log

mv metrics_$waktu.log /home/mken/log

#Crontab Setting
# * * * * * /home/mken/SISOPraktikum/soal_4/minute_log.sh
