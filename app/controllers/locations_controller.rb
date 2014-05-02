class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  # before_action :check_login
  load_and_authorize_resource

  def index
    check_login
    @locations = Location.all
    @active_locations = Location.active.alphabetical.paginate(:page => params[:page]).per_page(10)
    @inactive_locations = Location.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: "#{@location.name} location was added to the system !" }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: "#{@location.name} location was revised in the system !" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    status = @location.verify_that_never_used_for_camps
    if !status
      redirect_to :back, notice: "#{@location.name} is currently being used by a camp"
    else
      @location.destroy
      respond_to do |format|
        format.html { redirect_to locations_url, notice: "#{@location.name} has been deleted from the system" }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_location
      @location = Location.find(params[:id])
    end

    def location_params
      params.require(:location).permit(:name, :street_1, :street_2, :city, :state, :zip, :max_capacity, :latitude, :longitude, :active)
    end
end
