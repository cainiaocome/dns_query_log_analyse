#!/usr/bin/env bash

PWD=`pwd`
source $PWD/venv/bin/activate
cat $PWD/query.log | awk '{print $5}' | cut -d '#' -f 1 | sort | uniq | grep -v '198.211.0.204'>$PWD/ip
#cat query.log | awk '{print $2}' | cut -d '.' -f 1 | sort | uniq >seconds

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

#cat query.log | while read line; do
#    date=`echo $line | awk '{print $1}'`
#    second=`echo $line | awk '{print $2}' | cut -d '.' -f 1`
#    ip=`echo $line | awk '{print $5}' | cut -d '#' -f 1`
#    echo "$date, $second, $ip"
#    ./readintodb.py $date $second $ip
#done

rm -f $PWD/query.db && $PWD/create_database.py && $PWD/readintodb.py && $PWD/readfromdb.py >$PWD/ip.maybebad
cat $PWD/ip | while read ip; do
    count=`cat $PWD/ip.maybebad | grep $ip | wc -l`
    if [ $count -gt 8 ]; then
        echo $ip >>$PWD/ip.trulybad
    fi
done
