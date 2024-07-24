class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def show
    @site = Site.find_by(id: params[:id])
    if @site.nil?
      @site = Site.find_by(subdomain: request.subdomain)
    end
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      @site.site_users.create!(user: current_user, roles: 0)
      redirect_to site_root_url(subdomain: @site.subdomain), allow_other_host: true
    end
  end

  private

  def site_params
    params.require(:site).permit(:name, :subdomain, :background_color, :primary_color)
  end


end
