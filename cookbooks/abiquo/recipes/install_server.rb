# Cookbook Name:: abiquo
# Recipe:: install_server
#
# Copyright 2014, Abiquo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

%w(liquibase jdk).each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'mariadb::client'
include_recipe 'java::oracle_jce'
include_recipe 'abiquo::install_ext_services' if node['abiquo']['install_ext_services']

%w(server sosreport-plugins).each do |pkg|
  package "abiquo-#{pkg}" do
    action :install
  end
end

include_recipe 'abiquo::install_database'

if node['abiquo']['server']['install_frontend']
  include_recipe 'abiquo::install_ui'
  include_recipe 'abiquo::install_websockify'
end
