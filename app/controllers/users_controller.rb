class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  load_and_authorize_resource

  def index
    @users = User.alphabetical.paginate(:page => params[:page]).per_page(5)
  end

  def new
    @user = User.new
  end

  def edit
    # @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(home_path, :notice => 'user was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to(@user, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      if current_user && current_user.role?(:admin)
        params.require(:user).permit(:username, :password, :password_confirmation, :instructor_id, :role, :active)  
      else
        params.require(:user).permit(:username, :password, :password_confirmation, :instructor_id, :active)
      end
    end
end
