class IncidentsController < ApplicationController
  def create
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
