class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
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
