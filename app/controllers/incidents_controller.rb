class IncidentsController < ApplicationController
  before_action :set_incident, only: %i[show]

  def new
    @incident = Incident.new
    authorize @incident
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user
    @space = Space.find(params[:space_id])
    authorize @incident
    # if @incident.save
    #   redirect_to space_path
    # end
  end

  def update
  end

  def show
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
