require 'net/https'

module Google
  def process
    # grap information
    uri = URI('https://www.google.fr')

    start_time = Time.now
    Net::HTTP.get(uri) # => String
    Time.now - start_time
  end

  def collect
    info = ""
    10.times do |n|
      info << process.to_s
      info << "\n"
    end

    # save data to S3
    open("#{Dir.pwd}/../../S3/raw_data/#{Date.today.to_s}_google", 'a') { |file| file << "#{info}" }
  end
end
