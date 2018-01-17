require 'sinatra'
set :port, 6666

post '/' do
  data = JSON.parse(request.body.read)
  file_name = data['file_name']
  process_data(file_name)
  'true'
end

def process_data(file_name)
  File.readlines("../S3/raw_data/#{file_name}").each do |line|
    # process data
    good_data = translate(line.to_f)
    # export to fake S3
    open("#{Dir.pwd}/../S3/procced_data/#{file_name}", 'a') { |file| file << "#{good_data}\n" }
  end
end

def translate(data)
  '%.2f' % data
end
