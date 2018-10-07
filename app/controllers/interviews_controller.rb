class InterviewsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @interviews = @user.interviews
  end

  def new
    @interview = Interview.new
  end

  def create
    @interview = current_user.interviews.build(interview_params)
    if @interview.save
      flash[:success] = "面接希望日時が作成されました"
      redirect_to user_interviews_path
    else
      render 'interviews/new'
    end
  end

  def edit
  end

  private
    def interview_params
      params.require(:interview).permit(:schedule, :note)
    end
end
