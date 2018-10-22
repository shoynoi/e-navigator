class InterviewsController < ApplicationController
  before_action :correct_user, only: [:edit, :destroy, :update, :approve]
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @interviews = @user.interviews.order(schedule: :asc)
    @other_users = User.where.not(id: @user)
  end

  def new
    user = User.find(params[:user_id])
    if current_user?(user)
      @interview = current_user.interviews.build
    else
      flash[:danger] = "アクセスできません"
      redirect_to user_interviews_path(current_user)
    end
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

  def update
    if @interview.update_attributes(interview_params)
      flash[:success] = "面接希望日時を更新しました"
      redirect_to user_interviews_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @interview.destroy
    flash[:success] = "面接希望日時を削除しました。"
    redirect_to user_interviews_path(current_user)
  end

  def approve
    if @interview.update_attributes(status: "approved")
      @user.interviews.where.not(id: @interview).each do |interview|
        interview.update_attribute(:status, "rejected")
      end
      flash[:success] = "面接希望日時を承認しました"
      redirect_to user_interviews_path(@user)
    else
      flash[:danger] = "過去の日付は承認できません"
      redirect_to user_interviews_path(@user)
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

    def correct_user
      @user = User.find(params[:user_id])
      @interview = @user.interviews.find_by(id: params[:id])
      redirect_to root_url if @interview.nil?
    end

end
