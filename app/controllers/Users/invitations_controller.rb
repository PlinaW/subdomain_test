class Users::InvitationsController < Devise::InvitationsController
  before_action :set_current_site

  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      @users = @current_site.users

      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end

      resource.site_users.find_or_create_by(site: @current_site, roles: :member)

      respond_to do |format|
        if self.method(:after_invite_path_for).arity == 1
          location = after_invite_path_for(current_inviter)
        else
          location = after_invite_path_for(current_inviter, resource)
        end

        format.html { respond_with resource, location: location }

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("users", partial: "users/index/users_table", locals: { user: resource }),
            turbo_stream.update("flash", partial: "layouts/flash")
          ]
        end
      end
    else
      respond_with(resource)
    end
  end

  # PUT /resource/invitation
  def update
    raw_invitation_token = update_resource_params[:invitation_token]
    self.resource = accept_resource
    invitation_accepted = resource.errors.empty?

    yield resource if block_given?

    if invitation_accepted
      if resource.class.allow_insecure_sign_in_after_accept
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message :notice, flash_message if is_flashing_format?
        resource.after_database_authentication
        sign_in(resource_name, resource)
        redirect_to site_root_url(subdomain: current_user.site_users.first.site.subdomain), allow_other_host: true
      else
        set_flash_message :notice, :updated_not_active if is_flashing_format?
        respond_with resource, location: new_session_path(resource_name)
      end
    else
      resource.invitation_token = raw_invitation_token
      respond_with(resource)
    end
  end
end
