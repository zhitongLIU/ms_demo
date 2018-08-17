require 'grpc'
require 'collector_services_pb'

module Actions
  class GithubCollector
    # call collector google api to collect google data
    # if i call this function "call" it will run 2 time while being import => bug in ruby
    def run(*args)
      puts 'Calling Github collector'
      github_grpc_collector_url = ENV['GITHUB_COLLECTOR_HOST']
      github_grpc_collector_url ||= 'localhost:50051'
      puts "github_grpc_collector_url"
      puts github_grpc_collector_url

      stub = Collector::Github::Stub.new(github_grpc_collector_url, :this_channel_is_insecure)
      message = stub.collect(Collector::CollectRequest.new()).message
      message
    end
  end
end
