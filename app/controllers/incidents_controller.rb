class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[show edit]

  def new
    @incident = Incident.new
    authorize @incident
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user
    @space = Space.near([params[:lat], params[:lng]], 100).first || Space.first
    authorize @incident
    @incident.space = @space

    if @incident.save
      @notification = CommentNotification.with(incident: @incident)
      @notification.deliver(@space.user)
      redirect_to incident_path(@incident, lng: params[:lng], lat: params[:lat])
    end
  end


  def show
    @user = @incident.user
    # @space = @incident.space
    @space = @incident.space
    @markers = [
      {
        lat: @incident.space.latitude,
        lng: @incident.space.longitude,
        infoWindow: { content: render_to_string(partial: "/spaces/info_window", locals: { space: @space }) },
        image_url: helpers.asset_url(Cloudinary::Utils.cloudinary_url(@space.user.photo.key))
      }
    ]
    @message = @incident.messages
  end

  def edit
  end

  def update
    if @incident.update(incident_params)
      redirect_to edit_incident_path(@incident)
    else
      render :show
    end
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
    authorize @incident
  end

  def incident_params
    params.require(:incident).permit(:safe_status, :arrived)
  end
end
