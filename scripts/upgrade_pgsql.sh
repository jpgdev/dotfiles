#!/bin/bash
# Source : https://wiki.archlinux.org/index.php/PostgreSQL#Upgrading_PostgreSQL

## Set the old version that we want to upgrade from.
export FROM_VERSION=9.4
pg_root="/home/postgres"

pacman -S --needed postgresql-old-upgrade

chown postgres:postgres $pg_root

su - postgres -c "mv ${pg_root}/data ${pg_root}/data-${FROM_VERSION}"
su - postgres -c "mkdir ${pg_root}/data"
su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D ${pg_root}/data"
su - postgres -c "pg_upgrade -b /opt/pgsql-${FROM_VERSION}/bin/ -B /usr/bin/ -d ${pg_root}/data-${FROM_VERSION} -D ${pg_root}/data"
