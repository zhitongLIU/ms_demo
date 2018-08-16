require 'net/https'

module Github
  def process
    # grap information
    uri = URI('https://www.github.com')

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
    open("#{Dir.pwd}/../../S3/raw_data/#{Date.today.to_s}_github", 'a') { |file| file << "#{info}" }
  end
end
