class InterviewsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @interviews = @user.interviews
  end

  def new
  end

  def edit
  end
end
