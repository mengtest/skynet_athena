#!/bin/bash

export ATHENA_PORT=5188
export ATHENA_MYSQL_HOST='127.0.0.1'
export ATHENA_MYSQL_PORT=3306
export ATHENA_MYSQL_USER='root'
export ATHENA_MYSQL_DB='athena'
# export ATHENA_MYSQL_PWD='root'
export ATHENA_MYSQL_PWD='178dKeghLs9nVQdC'

./skynet/skynet ./etc/config.login
