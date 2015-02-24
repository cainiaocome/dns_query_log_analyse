#!/usr/bin/env bash

cat query.log | awk '{print $5}' | cut -d '#' -f 1 | sort | uniq | grep -v '198.211.0.204'>ip
cat query.log | awk '{print $2}' | cut -d '.' -f 1 | sort | uniq >seconds

#cat ip | while read ip; do
#    echo "start analyse $ip"
#    totalcount=`grep "$ip" query.log | wc -l`
#    echo "total count: $totalcount"
#    if [ $totalcount -gt 7000 ];then
#        beyondcount=0
#        cat seconds | while read second; do
#            secondcount=`cat query.log | grep $ip | grep $second | wc -l`
#            echo "$ip $second: $secondcount     beyondcount:$beyondcount"
#            if [ $secondcount -gt 7 ];then
#                beyondcount=$(($beyondcount+1))
#                echo $ip, $beyondcount
#            fi
#        done
#        if [ $beyondcount -gt 16 ];then
#            echo $ip, $beyondcount
#        fi
#    fi
#done
cat query.log | while read line; do
    date=`echo $line | awk '{print $1}'`
    second=`echo $line | awk '{print $2}' | cut -d '.' -f 1`
    ip=`echo $line | awk '{print $5}' | cut -d '#' -f 1`
    echo "$date, $second, $ip"
    ./readintodb.py $date $second $ip
done
