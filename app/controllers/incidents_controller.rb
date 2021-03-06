class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[show edit]

  def new
    @incident = Incident.new
    authorize @incident
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user
    @space = Space.near([params[:lat], params[:lng]], 100).where(available: true).reject do |space|
      current_user.spaces.find do |user_space|
        space == user_space
      end
    end.first || Space.first
    authorize @incident
    @incident.space = @space

    if @incident.save
      @notification = CommentNotification.with(incident: @incident, user: @incident.user, photo: render_to_string(partial: "notifications/notification"), notification: render_to_string(partial: "notifications/notification_current_user"))
      @notification.deliver(@space.user)
      redirect_to incident_path(@incident, lng: params[:lng], lat: params[:lat])
    end
  end

  def show
    @user = @incident.user
    @space = @incident.space
    @markers = [{
      lat: @incident.space.latitude,
      lng: @incident.space.longitude,
      info_window: render_to_string(partial: "/spaces/info_window", locals: { space: @space }),
      image_url: Cloudinary::Utils.cloudinary_url(@space.user.photo.key, secure: true)
    }]
    @usermarker = [{ image_url: Cloudinary::Utils.cloudinary_url(@user.photo.key, secure: true) }]
    @message = Message.new
    set_koban_markers
  end

  def edit
    @user = @incident.user
    @space = @incident.space
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

  def set_koban_markers
    @kobans = policy_scope(Koban)
    @koban_markers = @kobans.map do |koban|
      {
        lat: koban.latitude,
        lng: koban.longitude,
        info_window: render_to_string(partial: "/spaces/koban_info_window", locals: { koban: koban })
      }
    end
  end
end
