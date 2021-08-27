class SpacesController < ApplicationController
  before_action :set_space, only: %i[show]
  before_action :require_login, only: %i[index]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @spaces = policy_scope(Space)
    @spaces_location = Space.where.not(latitude: nil, longitude: nil)
    @markers = @spaces_location.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude,
        info_window: render_to_string(partial: "/spaces/info_window", locals: { space: space }),
        image_url: helpers.asset_url(Cloudinary::Utils.cloudinary_url(space.user.photo.key))
      }
    end
    @incident = Incident.new
  end

  def new
    @space = Space.new
    authorize @space
  end

  def create
    @space = Space.new(space_params)
    @space.user = current_user
    authorize @space
    if @space.save
      redirect_to spaces_path, notice: 'Space was successfully created.'
    else
      render :new
    end
  end

  def show
    @user = current_user
    @space_address = @space.address
    @markers = [
      {
        lat: @space.latitude,
        lng: @space.longitude,
        infoWindow: { content: render_to_string(partial: "/spaces/info_window", locals: { space: @space }) },
        image_url: helpers.asset_url(Cloudinary::Utils.cloudinary_url(@space.user.photo.key))
      }
    ]
    @safe_spaces = policy_scope(Space)
    @safe_spaces_location = Space.where.not(latitude: nil, longitude: nil, user: current_user)
    @safe_spaces_markers = @safe_spaces_location.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude,
        info_window: render_to_string(partial: "/spaces/info_window", locals: { space: space }),
        image_url: helpers.asset_url(Cloudinary::Utils.cloudinary_url(space.user.photo.key))
      }
    end
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

  def require_login
    unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_user_session_url # halts request cycle
    end
  end
end
