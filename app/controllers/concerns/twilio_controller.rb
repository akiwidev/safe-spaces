class Concerns::TwilioController < ApplicationController
  skip_before_action :authenticate_user!, only: [:connect]
  skip_forgery_protection
  skip_after_action :verify_authorized, only: [:connect]

  def call
    @incident = Incident.find(params[:id])
    authorize @incident
    if @incident.space.user == current_user
      TwilioService.new(@incident.user.phone_num).call
    else
      TwilioService.new(@incident.space.user.phone_num).call
    end
  end

  def connect
    response = Twilio::TwiML::VoiceResponse.new do |r|
      r.say(message: 'Connecting. One moment please.', voice: 'alice')
      r.dial number: params[:phone_number]
    end
    render xml: response.to_s
  end
end
