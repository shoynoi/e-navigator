class Interview < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2}
  belongs_to :user
  validates :status, :user_id, presence: true
  validates :schedule, presence: true, schedule: { allow_blank: true }
end
