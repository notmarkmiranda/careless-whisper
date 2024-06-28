class User < ApplicationRecord
  has_one_time_password after_column_name: :last_otp_at
  validates :phone_number, presence: true, uniqueness: true, phone: true

  before_validation :set_phone_number

  private

  def set_phone_number
    phonelib = Phonelib.parse(phone_number)
    self.phone_number = phonelib.sanitized if phonelib.valid?
  end
end
