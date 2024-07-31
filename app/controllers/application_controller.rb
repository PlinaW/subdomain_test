class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :check_registration_status

  private

  def set_current_site
    subdomain = request.subdomain
    @current_site = Site.find_by(subdomain: subdomain)

    if @current_site.nil?
      redirect_to root_url(subdomain: nil), alert: "Site not found"
    end
  end

  def check_registration_status
    if user_signed_in? && !current_user.completed_registration? && !on_site_creation_path?
      redirect_to new_site_path, alert: "Please complete your registration"
    end
  end

  def on_site_creation_path?
    controller_name == "sites" && action_name.in?(%w[new create])
  end
end
