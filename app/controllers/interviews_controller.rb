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
    @interview = Interview.find(params[:id])
  end

  def update
    @interview = Interview.find(params[:id])
    if @interview.update_attributes(interview_params)
      flash[:success] = "面接希望日時を更新しました"
      redirect_to user_interviews_path(current_user)
    else
      render 'edit'
    end
  end

  private
    def interview_params
      params.require(:interview).permit(:schedule, :note)
    end
end
