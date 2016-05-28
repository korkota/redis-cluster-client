require 'sinatra'
require 'json'
require './cluster'

startup_nodes = [
    {:host => "127.0.0.1", :port => 30001},
    {:host => "127.0.0.1", :port => 30002},
    {:host => "127.0.0.1", :port => 30003},
    {:host => "127.0.0.1", :port => 30004},
    {:host => "127.0.0.1", :port => 30005},
    {:host => "127.0.0.1", :port => 30006}
]

rc =  RedisCluster.new(startup_nodes,32,:timeout => 0.1)

configure do
  set :bind, '0.0.0.0'
  set :port, 12000 
end

get '/api/:command' do
  arguments = JSON.parse(params[:params])
  rc.send(params[:command], *arguments).to_json
end
