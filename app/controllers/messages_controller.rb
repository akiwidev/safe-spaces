class MessagesController < ApplicationController
  def new
    @message = Message.new
    @incident = Incident.find(params[:incident_id])
    authorize @message
  end

  def create
    @incident = Incident.find(params[:incident_id])
    @message = Message.new(message_params)
    @message.incident = @incident
    @message.user = current_user
    authorize @message
    if @message.save
      IncidentChannel.broadcast_to(
  @incident,
  render_to_string(partial: "message", locals: { message: @message })
)
      # redirect_to incident_path(@incident, anchor: "message-#{@message.id}")
    else
      render "incidents/show"
    end
  end

  private

  # def set_message
  #   @message = Message.find(params[:id])
  #   authorize @message
  # end

  def message_params
    params.require(:message).permit(:content, :id)
  end
end
