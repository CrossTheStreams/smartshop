#!/bin/sh

bin/rake db:create
bin/rake db:migrate
bin/rake db:seed TENANTS=3
