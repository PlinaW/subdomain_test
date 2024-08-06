class SitesController < ApplicationController
  before_action :set_current_site
  before_action :set_site, only: [ :show ]
  before_action :authorize_site_user, only: [ :show ]

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
    @site = @current_site
  end

  def authorize_site_user
    redirect_to(sites_url(subdomain: nil), allow_other_host: true, alert: "You are not a user of this site") unless @site.users.include?(current_user)
  end

  def site_params
    params.require(:site).permit(:name, :subdomain, :background_color, :primary_color)
  end
end
