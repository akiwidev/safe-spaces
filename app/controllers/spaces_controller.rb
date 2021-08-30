class SpacesController < ApplicationController
  before_action :set_space, only: %i[show edit update destroy]
  before_action :require_login, only: %i[index]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    set_space_markers
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
      redirect_to user_path(current_user), notice: 'Space was successfully created.'
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
    set_space_markers
    @incident = Incident.new

    @kobans = policy_scope(Koban)
    @koban_markers = @kobans.map do |koban|
      {
        lat: koban.latitude,
        lng: koban.longitude,
        info_window: render_to_string(partial: "/spaces/koban_info_window", locals: { koban: koban }),
        image_url: helpers.asset_url('police2.png')
      }
    end
  end

  def edit; end

  def update
    @user = current_user
    # if @space.update(space_params)
    #   redirect_to user_path(@user), notice: 'Your space has been updated'
    # else
    #   render :edit
    # end

    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to user_path(@user), notice: 'Your space has been updated' }
        format.js # Follow the classic Rails flow and look for a create.json view
      else
        format.html { render :edit }
        format.js # Follow the classic Rails flow and look for a create.json view
      end
    end
  end

  def destroy
    @user = current_user
    authorize @space
    @space.destroy
    redirect_to user_path(@user), notice: 'Your space was successfully removed'
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

  def set_space_markers
    @spaces = policy_scope(Space)
    @spaces_location = Space.where.not(latitude: nil, longitude: nil)
    @space_markers = @spaces_location.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude,
        info_window: render_to_string(partial: "/spaces/info_window", locals: { space: space }),
        image_url: helpers.asset_url(Cloudinary::Utils.cloudinary_url(space.user.photo.key))
      }
    end
  end
end
