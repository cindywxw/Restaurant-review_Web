class Reservation < ApplicationRecord

  belongs_to :restaurant
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'
  has_many :reviews, inverse_of: :Reservation

  # validate :res_date_before_din_date

  # def res_date_before_din_date
  #   if self.dine_at > self.reserve_at
  #     errors.add(:reserve_at, "Reserve date should be before dine date")
  #   end
  # end
  # validates :dine_at date: { after_or_equal_to: :reserve_at}

end
