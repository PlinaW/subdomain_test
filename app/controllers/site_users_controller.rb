class SiteUsersController < ApplicationController
  before_action :set_current_site
  def index
    @site_users = @current_site.site_users
  end
end
