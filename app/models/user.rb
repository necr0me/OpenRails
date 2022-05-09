class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:user, :moderator, :admin]
  has_one :user_info, dependent: :destroy
  has_many :tickets, dependent: :destroy
  accepts_nested_attributes_for(:user_info, allow_destroy: true)

  def initials
    self.user_info.present? ? "#{self.user_info.surname} #{self.user_info.name} #{self.user_info.patronymic}" : "user_id: #{self.id}"
  end
end
