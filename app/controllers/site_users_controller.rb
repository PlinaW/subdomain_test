class SiteUsersController < ApplicationController
  before_action :set_current_site

  def invite
    user = User.invite!(user_params, current_user)

    if user.valid?
      user.site_users.find_or_create_by(site: @current_site, roles: 1)
      redirect_to users_url(subdomain: @current_site.subdomain), notice: "#{user.email} was invited"
    else
      redirect_to users_url(subdomain: @current_site.subdomain), alert: "Invalid input: #{user.errors.full_messages.join(', ')}"
    end
  end

  private

  def user_params
    {
      email: params[:email],
      first_name: params[:first_name],
      last_name: params[:last_name]
    }
  end
end
