class SpacesController < ApplicationController
  before_action :set_space, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @spaces = policy_scope(Space)
  end

  def new
    @space = Space.new
    authorize @space
  end

  def create
  end

  def show
    @user = @space.user
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
