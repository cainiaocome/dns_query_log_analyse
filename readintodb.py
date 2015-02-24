#!/usr/bin/env python
#encoding: utf-8

import sqlite3
import sys

query_name = 'query.log'
db_name = 'query.db'
f = open(query_name, 'r')
select_sql = 'select * from query where date="{}" and second="{}" and ip="{}"'
insert_sql = 'insert into query values ("{}","{}","{}",{})'
update_sql = 'update query set count = {} where date="{}" and second="{}" and ip="{}"'

def process_record(date, second, ip):
    connection = sqlite3.connect(db_name)
    cursor = connection.cursor()

    try:
        cursor.execute(select_sql.format(date, second, ip))
        record = cursor.fetchone()
        if record==None:
            cursor.execute(insert_sql.format(date, second, ip, 1))
        else:
            print(record)
            count = record[3]
            count = count + 1
            cursor.execute(update_sql.format(count, date, second, ip))
    except sqlite3.OperationalError as e:
        print(e)

    connection.commit()
    connection.close()

def parse_line(line):
    line_splited = line.split(' ')
    date = line_splited[0]
    second = line_splited[1].split('.')[0]
    ip = line_splited[4].split('#')[0]
    return date, second, ip

while True:
    line = f.readline()
    if len(line)==0:
        break
    date, second, ip = parse_line(line)
    process_record(date, second, ip)    
sys.exit(0)

