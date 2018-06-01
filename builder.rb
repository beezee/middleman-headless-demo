require 'sinatra'

post '/' do
  `bundle exec middleman build`
end
