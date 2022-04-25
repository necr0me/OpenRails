class UserInfo < ApplicationRecord
  belongs_to :user
  belongs_to :discount, optional: true

  VALID_PASSPORT_CODE_REGEX = /[A-Za-zА-Яа-я]{2}\d{7}/i

  validates :name, presence: true, length: {minimum: 2, maximum: 50}
  validates :surname, presence: true, length: {minimum: 2, maximum: 50}
  validates :patronymic, presence: true, length: {minimum: 5, maximum: 50}

  validates :passport_code, presence: true,
                            format: VALID_PASSPORT_CODE_REGEX
  validates :phone_number, presence: true, length: {minimum: 7, maximum: 13}
end
