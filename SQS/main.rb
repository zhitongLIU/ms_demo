require 'listen'
require 'json'
require 'net/http'

# send post requst with json body: {"file_name": "XXX"}
def send_sqs(file_name)
  puts "send sqs #{file_name}"
  url = ENV['ETL_URL']
  url ||= 'http://localhost:6666'
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
  req.body = {file_name: file_name}.to_json
  http.request(req)
end

# this gem can listen to files change in a directory which can be used to fake
# our SQS on AWS
listener = Listen.to("#{Dir.pwd}/../S3/raw_data") do |modified, added, removed|
  # puts "modified absolute path: #{modified}"
  puts "added absolute path: #{added}"
  # puts "removed absolute path: #{removed}"
  path = added.first
  if path && !path.empty?
    file_name = path.split('/').last
    send_sqs file_name
  end
end
listener.start # not blocking
sleep

