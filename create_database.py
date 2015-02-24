#!/usr/bin/env python
#encoding: utf-8

import sqlite3
db_name = 'query.db'
create_table = 'create table query\
                (date text, second text, ip text, count int)'

connection = sqlite3.connect(db_name)
cursor = connection.cursor()

cursor.execute(create_table)

connection.commit()
connection.close()
