class InterviewsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create, :edit, :approve]
  before_action :correct_user, only: [:edit, :destroy, :update]
  before_action :authenticate_user!
  def index
    @interviews = @user.interviews.order(schedule: :asc)
    @others_email = User.where.not(id: @user).pluck(:email)
  end

  def new
    if current_user?(@user)
      @interview = current_user.interviews.build
    else
      redirect_to user_interviews_path(current_user), flash: { danger: "アクセスできません" }
    end
  end

  def create
    @interview = current_user.interviews.build(interview_params)
    if @interview.save
      redirect_to user_interviews_path, flash: { success: "面接希望日時が作成されました" }
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @interview.update(interview_params)
      redirect_to user_interviews_path(current_user), flash: { success: "面接希望日時を更新しました" }
    else
      render 'edit'
    end
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_path(current_user), flash: { success: "面接希望日時を削除しました" }
  end

  def approve
    @interview = Interview.find(params[:id])
    if @interview.update(status: "approved")
      @user.interviews.where.not(id: @interview).update_all(status: "rejected")
      InterviewMailer.with(interviewee: @user, interviewer: current_user, date: @interview.customized_schedule_format)
          .interview_confirmed
          .deliver_now
      redirect_to user_interviews_path(@user), flash: { success: "面接希望日時を承認しました" }
    else
      redirect_to user_interviews_path(@user), flash: { danger: "過去の日付は承認できません" }
    end
  end

  def apply
    @interviewee = User.find(params[:user_id])
    @interviewer = params[:interviewer]
    InterviewMailer.with(interviewee: @interviewee, interviewer: @interviewer).interview_application.deliver_now
    flash[:success] = "申請が完了しました"
    redirect_to user_interviews_path(@interviewee)
  end

  private

    def interview_params
      params.require(:interview).permit(:schedule, :note)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def correct_user
      @interview = current_user.interviews.find_by(id: params[:id])
      redirect_to root_url if @interview.nil?
    end

end
