class Interview < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2}
  belongs_to :user
  validates :schedule, :status, :user_id, presence: true
  validate :schedule_date_cannot_be_in_the_past

  def customized_schedule_format
    schedule.strftime('%Y年%m月%d日 %H:%M')
  end

  def schedule_date_cannot_be_in_the_past
    if schedule.present? && schedule < DateTime.now
      errors.add(:schedule, "can't be in the past")
    end
  end
end
