class SitesController < ApplicationController
  before_action :set_site

  def index
    @sites = Site.all
  end

  def show
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

  def set_site
    @site = Site.find_by(subdomain: request.subdomain)
    if @site.nil?
      flash[:alert] = "Couldn't find this site"
      redirect_to root_url(subdomain: nil), allow_other_host: true
    end
  end

  def site_params
    params.require(:site).permit(:name, :subdomain, :background_color, :primary_color)
  end
end
