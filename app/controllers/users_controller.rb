class UsersController < ApplicationController
  before_action :authenticate_user!, only: :index

  def root
    if user_signed_in?
      redirect_to users_path
    else
      redirect_to new_user_session_path
    end
  end

  def index
    @users = User.where.not(id: current_user.id)
  end
end
