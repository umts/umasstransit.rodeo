# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :find_user, except: %i[index manage]
    before_action { require_role :admin }

    def approve
      @user.approve!
      redirect_to manage_admin_users_path, notice: t('.success', name: @user.name)
    end

    def index
      @page_title = 'User Roles'
      @users = User.order(:name)
    end

    def update
      return unless @user.update user_params

      redirect_to admin_users_path, notice: t('.success')
    end

    def destroy
      @user.destroy!
      redirect_back_or_to admin_users_path, notice: t('.success')
    end

    def manage
      @page_title = 'Manage Users'
      @users = User.unapproved.order :name
    end

    private

    def find_user
      @user = User.find_by id: params.require(:id)
    end

    def user_params
      params.expect user: %i[admin quiz_scorer circle_check_scorer master_of_ceremonies judge]
    end
  end
end
