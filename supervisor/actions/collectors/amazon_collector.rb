require 'bunny'

module Actions
  class AmazonCollector
    # send message to amazon collector to collect amazon data
    # if i call this function "call" it will run 2 time while being import => bug in ruby
    def run(*args)
      puts 'Calling amazon collector'

      # get connection information
      rabbitmq_host = ENV['RABBITMQ_HOST']
      rabbitmq_host ||= 'localhost'

      # start a connection
      # conn = Bunny.new(host: rabbitmq_host, vhost: '/', port: 5672, user: 'user', password: 'password')
      # conn.start
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

      # define exchange to be used
      exchange_name = 'collectors_exchange'
      routing_key = 'amazon'

      ch = conn.create_channel
      x = ch.direct(exchange_name)

      x.publish('start', routing_key: routing_key)
      conn.close
    end
  end
end
