class IncidentChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    incident = Incident.find(params[:id])
    stream_for incident
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
