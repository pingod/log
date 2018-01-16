#!/usr/bin/env bash

version=6.1.1

rpm -ivh https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$version-x86_64.rpm
rpm -ivh https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-$version-x86_64.rpm

#filebeat模块的配置在/etc/filebeat/modules.d/
cp filebeat/filebeat.yaml /etc/filebeat/filebeat.yml

#metricbeat模块的配置在 /etc/metricbeat/modules.d
cp filebeat/metricbeat.yml /etc/metricbeat/metricbeat.yml

filebeat setup --dashboards
filebeat setup --machine-learning
filebeat setup --template

metricbeat setup --dashboards
metricbeat setup --machine-learning
metricbeat setup --template

#匹配规则在 ll /usr/share/filebeat/module/*/*/ingest/*
#可根据特有日志格式修改对应的json

systemctl enable filebeat
systemctl start filebeat

systemctl enable metricbeat
systemctl start metricbeat