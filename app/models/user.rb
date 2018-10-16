class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum gender: { man: 0, woman: 1 }
  has_many :interviews
  validate :birthday_cannot_be_in_the_future

  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthday.strftime(date_format).to_i) / 10000
  end

  private
    def birthday_cannot_be_in_the_future
      if birthday.present? && birthday.future?
        errors.add(:birthday, ": 未来の日付は使用できません。")
      end
    end
end
