class Interview < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2}
  belongs_to :user
end
