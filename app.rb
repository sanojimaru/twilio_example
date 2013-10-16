require 'sinatra'
require "sinatra/reloader" if development?
require 'twilio-ruby'

set :twilio_from, '+15406573053'
set :twilio_sid, 'AC853f0e66879ca9fbd411230837118a95'
set :twilio_auth_token, '2f7df85eff1dfd31db3b2d86d9388ca0'
set :twilio_number, ''

def client
  Twilio::REST::Client.new(settings.twilio_sid, settings.twilio_auth_token)
end

get '/' do
  haml :index
end

post '/call' do
  @to = params[:to]

  call = client.account.calls.create(
    from: settings.twilio_from,
    to: "+#{@to}",
    url: to('/'), )

  redirect to('/')
end


post '/sms' do
  @to = params[:to]

  client.account.sms.messages.create(
    from: settings.twilio_from,
    to: "+#{@to}",
    body: 'Hey there!', )

  redirect to('/')
end
