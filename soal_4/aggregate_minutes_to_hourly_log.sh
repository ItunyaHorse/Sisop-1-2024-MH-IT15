#!/bin/bash

jam=$(date -d '1 hour ago' +"%Y%m%d%H")

echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_agg_$jam.log



for file in /home/mken/log/*;
do
 if [[ $file = *$jam* ]]
 then
 cat $file | awk 'NR==2 {print}' >> hourly_log.txt
 fi
done

mina=$(awk -F ',' '{print $1}' hourly_log.txt | sort -n | head -1)
minb=$(awk -F ',' '{print $2}' hourly_log.txt | sort -n | head -1)
minc=$(awk -F ',' '{print $3}' hourly_log.txt | sort -n | head -1)
mind=$(awk -F ',' '{print $4}' hourly_log.txt | sort -n | head -1)
mine=$(awk -F ',' '{print $5}' hourly_log.txt | sort -n | head -1)
minf=$(awk -F ',' '{print $6}' hourly_log.txt | sort -n | head -1)
ming=$(awk -F ',' '{print $7}' hourly_log.txt | sort -n | head -1)
minh=$(awk -F ',' '{print $8}' hourly_log.txt | sort -n | head -1)
mini=$(awk -F ',' '{print $9}' hourly_log.txt | sort -n | head -1)
minj=$(awk -F ',' '{print $11}' hourly_log.txt | sort -n | head -1)

echo "minimum,$mina,$minb,$minc,$mind,$mine,$minf,$ming,$minh,$mini,/home/mken,$minj" >> metrics_agg_$jam.log

maxa=$(awk -F ',' '{print $1}' hourly_log.txt | sort -n | tail -1)
maxb=$(awk -F ',' '{print $2}' hourly_log.txt | sort -n | tail -1)
maxc=$(awk -F ',' '{print $3}' hourly_log.txt | sort -n | tail -1)
maxd=$(awk -F ',' '{print $4}' hourly_log.txt | sort -n | tail -1)
maxe=$(awk -F ',' '{print $5}' hourly_log.txt | sort -n | tail -1)
maxf=$(awk -F ',' '{print $6}' hourly_log.txt | sort -n | tail -1)
maxg=$(awk -F ',' '{print $7}' hourly_log.txt | sort -n | tail -1)
maxh=$(awk -F ',' '{print $8}' hourly_log.txt | sort -n | tail -1)
maxi=$(awk -F ',' '{print $9}' hourly_log.txt | sort -n | tail -1)
maxj=$(awk -F ',' '{print $11}' hourly_log.txt | sort -n | tail -1)

echo "maximum,$maxa,$maxb,$maxc,$maxd,$maxe,$maxf,$maxg,$maxh,$maxi,/home/mken,$maxj" >> metrics_agg_$jam.log


jumlaha=0
totala=0
for i in $(awk -F ',' '{print $1}' hourly_log.txt)
   do
     totala=$(($totala+$i))
     ((jumlaha++))
   done
rataa=$(($totala/$jumlaha)) 

jumlahb=0
totalb=0
for i in $(awk -F ',' '{print $2}' hourly_log.txt)
   do
     totalb=$(($totalb+$i))
     ((jumlahb++))
   done
ratab=$(($totalb/$jumlahb))

jumlahc=0
totalc=0
for i in $(awk -F ',' '{print $3}' hourly_log.txt)
   do
     totalc=$(($totalc+$i))
     ((jumlahc++))
   done
ratac=$(($totalc/$jumlahc))

jumlahd=0
totald=0
for i in $(awk -F ',' '{print $4}' hourly_log.txt)
   do
     totald=$(($totald+$i))
     ((jumlahd++))
   done
ratad=$(($totald/$jumlahd))

jumlahe=0
totale=0
for i in $(awk -F ',' '{print $5}' hourly_log.txt)
   do
     totale=$(($totale+$i))
     ((jumlahe++))
   done
ratae=$(($totale/$jumlahe))

jumlahf=0
totalf=0
for i in $(awk -F ',' '{print $6}' hourly_log.txt)
   do
     totalf=$(($totalf+$i))
     ((jumlahf++))
   done
rataf=$(($totalf/$jumlahf))

jumlahg=0
totalg=0
for i in $(awk -F ',' '{print $7}' hourly_log.txt)
   do
     totalg=$(($totalg+$i))
     ((jumlahg++))
   done
ratag=$(($totalg/$jumlahg))

jumlahh=0
totalh=0
for i in $(awk -F ',' '{print $8}' hourly_log.txt)
   do
     totalh=$(($totalh+$i))
     ((jumlahh++))
   done
ratah=$(($totalh/$jumlahh))

jumlahi=0
totali=0
for i in $(awk -F ',' '{print $9}' hourly_log.txt)
   do
     totali=$(($totali+$i))
     ((jumlahi++))
   done
ratai=$(($totali/$jumlahi))

jumlahj=0
totalj=0
for i in $(awk -F ',' '{print $11}' hourly_log.txt)
   do
     totalj=$(($totalj+$i))
     ((jumlahj++))
   done
rataj=$(($totalj/60))

echo "average,$rataa,$ratab,$ratac,$ratad,$ratae,$rataf,$ratag,$ratai,/home/mken,$rataj" >> metrics_agg_$jam.log

rm hourly_log.txt


#Crontab Settings
# 0 * * * * /home/mken/SISOPraktikum/soal_4/aggregate_minutes_to_hourly_log.sh
