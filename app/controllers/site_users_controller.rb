class SiteUsersController < ApplicationController
  before_action :set_current_site
  def index
    @site_users = @current_site.site_users
  end

  def invite
    email = params[:email]
    return redirect_to site_users_url(subdomain: @current_site.subdomain), alert: "No email provided" if email.blank?

    user = User.invite!({ email: }, current_user)
    return redirect_to site_users_url(subdomain: @current_site.subdomain), alert: "Email invalid" unless user.valid?

    user.site_users.find_or_create_by(site: @current_site, roles: 1)

    redirect_to site_users_url(subdomain: @current_site.subdomain), notice: "#{email} was invited"

    # binding.b
  end
end
