class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :check_registration_status
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:invite, keys: [ :first_name, :last_name ])
  end

  def set_current_site
    @current_site = request.env["current_site"]

    if @current_site.nil?
      redirect_to root_url(subdomain: nil), allow_other_host: true, alert: "Site not found"
    end

    # if !@current_site && !@sites.include?(@current_site&.subdomain)
    #   flash[:alert] = "Site not found"
    #   redirect_to root_url(subdomain: nil), allow_other_host: true
    # end
  end

  # def set_current_site
  #   subdomain = request.subdomain
  #   @current_site = Site.find_by(subdomain: subdomain)

  #   if @current_site.nil?
  #     redirect_to root_url(subdomain: nil), alert: "Site not found"
  #   end
  # end

  def check_registration_status
    if user_signed_in? && !current_user.completed_registration? && !on_site_creation_path?
      redirect_to new_site_path, alert: "Please complete your registration"
    end
  end

  def on_site_creation_path?
    controller_name == "sites" && action_name.in?(%w[new create])
  end
end
