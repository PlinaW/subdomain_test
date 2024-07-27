class SitesController < ApplicationController
  before_action :set_current_site, only: [ :show ]

  def index
    @sites = Site.all
  end

  def show
    @site = @current_site
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      @site.site_users.create!(user: current_user, roles: 0)
      current_user.update(completed_registration: true)
      redirect_to site_root_url(subdomain: @site.subdomain), allow_other_host: true
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :subdomain, :background_color, :primary_color)
  end
end
