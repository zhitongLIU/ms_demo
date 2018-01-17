require 'pg'
require 'active_record'
require_relative 'actions/actions'

host = ENV["DATABASE_HOST"]
host ||= 'localhost'

ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3'
  database: 'api_production',
  username: 'user',
  password: 'password',
  host:     host
)

# this shared class import can be done by doing a gem
class Job < ActiveRecord::Base
end

while true do
  Job.where(status: 'created').each do |job|
    puts job
    case job.name
    when 'google'
      Actions::GoogleCollector.new.run
      job.update(status: 'posted')
    when 'amazon'
      Actions::AmazonCollector.new.run
      job.update(status: 'posted')
    else
      next
    end
  end
  sleep 10
end
