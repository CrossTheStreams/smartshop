#!/bin/sh

bin/rake db:create

psql -f ./script/create_remote_server.sql --dbname=smartshop_development

bin/rake db:migrate
git checkout -- db/structure.sql
bin/rake db:seed TENANTS=5
