class HomeController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    if authenticated?
      redirect_to dashboard_path
    else
      render :index
    end
  end
end
