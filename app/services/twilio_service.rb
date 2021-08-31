require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/console
account_sid = ENV['TWILIO_ACC_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(account_sid, auth_token)

call = @client.calls.create(
    to: "+817040990983",
    from: "+14433314397",
    url: "http://demo.twilio.com/docs/voice.xml")
puts call.to
