require 'twilio-ruby'

class TwilioService
  def initialize(attributes = {})
    @receiver = attributes[:receiver]
    @sender = attributes[:sender]
  end

  def call
    # Get your Account Sid and Auth Token from twilio.com/console
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    p url = "#{ENV['DOMAIN']}/connect/#{@sender}"
    call = @client.calls.create(
      to: @receiver,
      from: "+14433314397",
      url: url
    )
    puts call.to
  end
end
