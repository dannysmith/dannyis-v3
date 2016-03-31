require 'bundler/setup'
require 'dotenv'
require 'sinatra/base'
require 'sinatra/content_for'
require 'net/http'
require 'yaml'
require 'redcarpet'
# require 'active_support/all'

Dotenv.load
Dir[File.dirname(__FILE__) + '/lib/*'].each { |f| require f }

require './dannyis'

if ENV['RACK_ENV'] == 'development'
  require 'pry'
elsif ENV['RACK_ENV'] == 'production'
  use Rack::Deflater #Enable GZip Compression
end

run DannyIs::App
