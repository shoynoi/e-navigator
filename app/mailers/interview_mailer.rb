class InterviewMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.interview_mailer.interview_application.subject
  #
  def interview_application
    @interviewer = params[:interviewer]
    @interviewee = params[:interviewee]

    mail to: @interviewer, subject: "面接希望日が決まりました"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.interview_mailer.interview_confirmed.subject
  #
  def interview_confirmed
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
