class Admin::UsersController < ApplicationController
  before_action :find_user, except: :index

  def destroy
    deny_access && return unless current_user.has_role? :admin
    @user.destroy!
    redirect_to admin_users_path,
                notice: 'User has been removed.'
  end

  def index
    @users = User.order(:name)
  end

  def update
    deny_access && return unless current_user.has_role? :admin
    if @user.update user_params
    redirect_to admin_users_path,
                notice: 'User has been updated.'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  private 

  def find_user
    @user = User.find_by id: params.require(:id)
  end

  def user_params
    params.require(:user).permit :admin, :quiz_scorer, :circle_check_scorer, 
                                  :master_of_ceremonies, :judge
  end
end