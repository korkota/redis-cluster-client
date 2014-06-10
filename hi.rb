require 'sinatra'
require 'json'
require './cluster'

startup_nodes = [
    {:host => "127.0.0.1", :port => 7000},
    {:host => "127.0.0.1", :port => 7001},
    {:host => "127.0.0.1", :port => 7002},
    {:host => "127.0.0.1", :port => 7003},
    {:host => "127.0.0.1", :port => 7004},
    {:host => "127.0.0.1", :port => 7005}
]

rc =  RedisCluster.new(startup_nodes,32,:timeout => 0.1)

configure do
  set :bind, '192.168.2.101'
  set :port, 12000 
end

get '/api/:command' do
  arguments = JSON.parse(params[:params])
  rc.send(params[:command], *arguments).to_json
end
