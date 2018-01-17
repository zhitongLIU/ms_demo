require 'sinatra'
require_relative 'google'
include Google

get '/' do
  Google.collect
  "{ 'success': true }"
end
