class InterviewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.interview_mailer.interview_application.subject
  #
  def apply
    @interviewer = params[:interviewer]
    @interviewee = params[:interviewee]

    mail to: @interviewer, subject: "面接希望日が決まりました"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.interview_mailer.interview_confirmed.subject
  #
  def confirm
    @interviewer = params[:interviewer]
    @interviewee = params[:interviewee]
    @interview_date = params[:date]

    mail to: %W(#{@interviewer.email} #{@interviewee.email}), subject: "面接日時が確定しました"
  end
end
