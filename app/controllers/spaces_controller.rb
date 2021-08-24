class SpacesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @spaces = policy_scope(Space)
  end

  def new
  end

  def create
  end

  def show
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
