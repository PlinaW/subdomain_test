class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_current_site
  def index
  end
end
