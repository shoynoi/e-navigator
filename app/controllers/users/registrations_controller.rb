# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :correct_user, only: [:edit]

  def edit
    super
  end

  private
    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to root_path unless @user == current_user
    end
end
