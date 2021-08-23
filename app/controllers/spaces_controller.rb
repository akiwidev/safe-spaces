class SpacesController < ApplicationController
  def new
  end

  def create
  end

  def show
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
    params.require(:space).permit(:conditions, :available, :address)
  end
end
