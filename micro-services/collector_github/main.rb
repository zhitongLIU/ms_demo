require_relative 'github'
include Github
require_relative './deps'

# GithubServiceServer is simple server that implements the Helloworld Greeter server.
class GithubServiceServer < Collector::Github::Service
  # say_hello implements the SayHello rpc method.
  def collect(_req, _unused_call)
    Github.collect
    Collector::CollectReply.new(message: 'success')
  end
end

# main starts an RpcServer that receives requests to GithubServiceServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  github_grpc_collector_host = ENV['GITHUB_COLLECTOR_HOST']
  github_grpc_collector_host ||= '0.0.0.0:50051'

  s.add_http2_port(github_grpc_collector_host, :this_port_is_insecure)
  s.handle(GithubServiceServer)
  s.run_till_terminated
end

main
