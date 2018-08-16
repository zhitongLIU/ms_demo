require 'sinatra'
require_relative 'google'
include Google

get '/' do
  Github.collect
  "{ 'success': true }"
end
