module InterviewsHelper

  def confirmed?(interview)
    interview.user_id == current_user.id && interview.status != 'pending'
  end
end
