class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    check_login
    @upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
    @past_camps = Camp.past.chronological.paginate(:page => params[:page]).per_page(10)
    @inactive_camps = Camp.inactive.alphabetical.to_a
  end

  def show
    @instructors = @camp.instructors.alphabetical.to_a
  end

  def new
    @camp = Camp.new
    @camp.registrations.build
  end

  def edit
  end

  def create
    @camp = Camp.new(camp_params)
    if @camp.save
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was added to the system."
    else
      render action: 'new'
    end
  end

  def update
    @camp.start_date = convert_to_datetime(params[:camp][:start_date])
    @camp.end_date = convert_to_datetime(params[:camp][:end_date])

    if @camp.update(camp_params)
      redirect_to @camp, notice: "The camp #{@camp.name} (on #{@camp.start_date.strftime('%m/%d/%y')}) was revised in the system."
    else
      render action: 'edit'
    end
  end

  def destroy
    status = @camp.verify_that_there_are_no_registrations_for_camp
    if !status
      redirect_to :back, notice: "#{@camp.name} camp on #{@camp.start_date.strftime('%m/%d/%y')} cannot be removed from the system. Has Registrations !"
    else
      @camp.destroy
      redirect_to camps_url, notice: "#{@camp.name} camp on #{@camp.start_date.strftime('%m/%d/%y')} was removed from the system."
    end
  end

  private
    def convert_start_date
      params[:camp][:start_date] = convert_to_date(params[:camp][:start_date]) unless params[:camp][:start_date].blank?
    end

    def convert_end_date
      params[:camp][:end_date] = convert_to_date(params[:camp][:end_date]) unless params[:camp][:end_date].blank?
    end

    def set_camp
      @camp = Camp.find(params[:id])
    end

    def camp_params
      convert_start_date
      convert_end_date
      params.require(:camp).permit(:curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, :max_students, :active, :instructor_ids => [], registrations_attributes: [ :id, :camp_id, :student_id, :payment_status, :points_earned])
    end
end
