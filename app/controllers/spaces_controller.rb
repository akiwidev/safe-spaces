class SpacesController < ApplicationController
  before_action :set_space, only: %i[show]
  def new
  end

  def create
  end

  def show
    #we want the user to click on a marker to get info about a safe space
    @user = @space.user
  end

  def index
  end

  def update
  end

  def destroy
  end

  private

  def set_space
    @space = Space.find(params[:id])
    authorize @space
  end

  def space_params
    params.require(:space).permit(:conditions, :available, :address, :photo)
  end
end
