class SiteUsersController < ApplicationController
  before_action :set_current_site

  def invite
    email = params[:email]
    first_name = params[:first_name]
    last_name = params[:last_name]

    return redirect_to users_url(subdomain: @current_site.subdomain), alert: "No email provided" if email.blank?

    user = User.invite!({ email: email, first_name: first_name, last_name: last_name }, current_user)
    return redirect_to users_url(subdomain: @current_site.subdomain), alert: "Email invalid" unless user.valid?

    user.site_users.find_or_create_by(site: @current_site, roles: 1)

    redirect_to users_url(subdomain: @current_site.subdomain), notice: "#{email} was invited"

    # binding.b
  end
end
