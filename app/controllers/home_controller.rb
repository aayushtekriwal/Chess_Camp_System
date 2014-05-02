class HomeController < ApplicationController
  def index
    @upcoming_camps = Camp.upcoming.active.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def about
  end

  def contact
  end

  def guest
  end

  def help
  end

  def privacy
  end

  def home
    if logged_in?
      # get my camps
      @camps = current_user.camps.alphabetical.to_a
    end
  end
  
end
