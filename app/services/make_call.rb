require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/console
account_sid = 'AC9d0b9cb9d2835fd77fbb203a088a8b21'
auth_token = 'eefee6d810f6e525f0c658f122ef6341'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(account_sid, auth_token)

call = @client.calls.create(
    to: "+817040990983",
    from: "+14433314397",
    url: "http://demo.twilio.com/docs/voice.xml")
puts call.to
