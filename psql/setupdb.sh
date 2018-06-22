#!/usr/bin/env bash
echo "DROP DATABASE IF EXISTS ssdb;" | sudo -u postgres psql
echo "DROP USER IF EXISTS ssuser;" | sudo -u postgres psql
echo "CREATE USER ssuser WITH PASSWORD '1234';" | sudo -u postgres psql
echo "CREATE DATABASE ssdb;" | sudo -u postgres psql
echo "GRANT ALL PRIVILEGES ON DATABASE "ssdb" to ssuser;" | sudo -u postgres psql
psql -h localhost -d ssdb -U ssuser -f schema.sql
echo "INSERT INTO catalogs (id, name) VALUES (2, 'sonytest');" | psql -h localhost -U ssuser -d ssdb

