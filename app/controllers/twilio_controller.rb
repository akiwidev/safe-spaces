class TwilioController < ApplicationController
  skip_before_action :authenticate_user!, only: [:connect, :call]
  skip_forgery_protection
  skip_after_action :verify_authorized, only: [:connect, :call]

  def call
    @incident = Incident.find(params[:id])
    TwilioService.new(sender: @incident.user.phone_num, receiver: @incident.space.user.phone_num).call
  end

  def connect
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(message: 'Connecting you to the homeowner of your nearest safe space. One moment please.', voice: 'alice')
      r.dial number: params[:phone_number]
    end
    render xml: response.to_s
  end
end
