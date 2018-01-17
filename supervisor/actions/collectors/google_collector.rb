require 'net/http'

module Actions
  class GoogleCollector
    # call collector google api to collect google data
    # if i call this function "call" it will run 2 time while being import => bug in ruby
    def run(*args)
      puts 'Calling google collector'
      google_collector_url = ENV['GOOGLE_COLLECTOR_URL']
      google_collector_url ||= 'http://localhost:4567'
      uri = URI(google_collector_url)
      Net::HTTP.get(uri)
    end
  end
end
