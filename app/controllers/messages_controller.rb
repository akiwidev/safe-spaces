class MessagesController < ApplicationController
  def new
  end

  def create
  end

  private

  # def set_message
  #   @message = Message.find(params[:id])
  #   authorize @message
  # end

  def message_params
    params.require(:message).permit(:content)
  end
end
