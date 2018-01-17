require_relative 'amazon'
require 'bunny'
include Amazon

# get connection information
rabbitmq_host = ENV['RABBITMQ_HOST']
rabbitmq_host ||= 'localhost'
# retry connection 3 time, sometime docker compose launch this program while rabbitmq not completly started even with `depends_on`
successed = false
retry_time = 0
while !successed && retry_time < 3 do
  begin
    # start a connection
    conn = Bunny.new(host: rabbitmq_host, vhost: '/', port: 5672, user: 'user', password: 'password')
    conn.start
  rescue Bunny::TCPConnectionFailedForAllHosts
    puts '[*] failed to connect to rabbitmq,  retry in 30'
    retry_time += 1
    sleep 30
  else
    successed = true
  end
end

# define exchange and queue name to be used
exchange_name = 'collectors_exchange'
queue_name = 'amazon_collector'
routing_key = 'amazon'

# connect to a channel
ch = conn.create_channel
# specify a queue
x = ch.direct(exchange_name)
# recive message from queue using specify routing key
q = ch.queue(queue_name).bind(x, routing_key: routing_key)

# subscribe to queue
begin
  # pp ' [*] Waiting for messages. To exit press CTRL+C'
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] Recived #{body}"
    # if message body include start then start the job
    if body.include? 'start'
      Amazon.collect
    end
    # we could imagin we have stop and restart
  end
rescue Interrupt => _
  conn.close
  exit(0)
end
