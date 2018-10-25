class InterviewsController < ApplicationController
  before_action :set_user, only: [:index, :new, :create, :edit]
  before_action :correct_user, only: [:edit, :destroy, :update]
  before_action :authenticate_user!
  def index
    @interviews = @user.interviews.order(schedule: :asc)
  end

  def new
    if current_user?(@user)
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
      render 'new'
    end
  end

  def edit
  end

  def update
    if @interview.update(interview_params)
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
