#!/usr/bin/env python
#encoding: utf-8

import sqlite3
import sys

db_name = 'query.db'
select_sql = 'select ip from query where count>10'


connection = sqlite3.connect(db_name)
cursor = connection.cursor()

try:
    cursor.execute(select_sql)
    records = cursor.fetchall()
    for record in records:
        print(record[0])
except sqlite3.OperationalError as e:
    print(e)

connection.commit()
connection.close()
