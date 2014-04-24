class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]

  def index
    @families = Family.all
  end

  def show
  end

  def new
    @family = Family.new
  end

  def edit
  end

  def create
    @family = Family.new(family_params)

    respond_to do |format|
      if @family.save
        format.html { redirect_to @family, notice: 'Family was successfully created.' }
        format.json { render action: 'show', status: :created, location: @family }
      else
        format.html { render action: 'new' }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to @family, notice: 'Family was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url }
      format.json { head :no_content }
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:family_name, :parent_first_name, :email, :phone, :active)
    end
end
