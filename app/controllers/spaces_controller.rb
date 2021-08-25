class SpacesController < ApplicationController
  before_action :set_space, only: %i[show]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @spaces = policy_scope(Space)
    @spaces_location = Space.where.not(latitude: nil, longitude: nil)
    @markers = @spaces_location.map do |space|
      {
        lat: space.latitude,
        lng: space.longitude,
        # icon: Cloudinary::Utils.cloudinary_url(space.user.photo.key), #{ width: 50, height: 50, crop: :fill, radius: :max }),
        infoWindow: { content: render_to_string(partial: "/spaces/info_window", locals: { space: space }) }
        # Uncomment the above line if you want each of your markers to display a info window when clicked
        # (you will also need to create the partial "/flats/map_box")
      }
    end
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
