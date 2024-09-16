class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :set_current_site

  def index
    @q = @current_site.users.ransack(params[:q])
    @users = @q.result.includes(:site_users)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully"
      redirect_to user_url(subdomain: @user.site_users.first.site.subdomain), allow_other_host: true
    else
      render edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :phone_number,
                                 :country,
                                 :city,
                                 :zip_code,
                                 :address,
                                 :birthday,
                                 :languages,
                                 :education,
                                 :work_history,
                                 :about_me,
                                 :hobbies,
                                 :skills)
  end
end
