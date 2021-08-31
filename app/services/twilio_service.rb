require 'twilio-ruby'

# Get your Account Sid and Auth Token from twilio.com/console
account_sid = 'AC9d0b9cb9d2835fd77fbb203a088a8b21'
auth_token = 'your_auth_token'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new(account_sid, auth_token)

call = @client.calls.create(
    to: "+15558675310",
    from: ENV['TWILIO_NUM'],
    url: "http://demo.twilio.com/docs/voice.xml")
puts call.to
