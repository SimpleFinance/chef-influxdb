# resources/continuous_query.rb

# Resource for InfluxDB database

property :name, String, name_property: true
property :database, String
property :query, String
property :auth_username, String, default: 'root'
property :auth_password, String, default: 'root'

default_action :create

action :create do
  client.create_continuous_query(name, database, query)
  updated_by_last_action true
end

action :delete do
  client.delete_continuous_query(name, database)
  updated_by_last_action true
end

def client
  require 'influxdb'
  @client ||=
    InfluxDB::Client.new(
      username: auth_username,
      password: auth_password,
      retry: 10
    )
end
