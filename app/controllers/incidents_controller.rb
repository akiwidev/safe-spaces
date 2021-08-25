class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[show]

  def new
    @incident = Incident.new
    authorize @incident
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user
    @space = Space.find_by(id: params[:space_id]) || Space.first
    authorize @incident
    @incident.space = @space
    if @incident.save
      redirect_to incident_path(@incident)
    end
  end

  def update
  end

  def show
    @user = @incident.user
    @space = @incident.space
    @markers = [
      {
        lat: @space.latitude,
        lng: @space.longitude,
        # icon: Cloudinary::Utils.cloudinary_url(space.user.photo.key), #{ width: 50, height: 50, crop: :fill, radius: :max }),
        infoWindow: { content: render_to_string(partial: "/spaces/info_window", locals: { space: @space }) }
        # Uncomment the above line if you want each of your markers to display a info window when clicked
        # (you will also need to create the partial "/flats/map_box")
      }
    ]
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
