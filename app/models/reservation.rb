class Reservation < ApplicationRecord

  belongs_to :restaurant
  belongs_to :user
  
  belongs_to :guest, class_name: 'User', foreign_key: 'user_id'
  has_many :reviews

  validates :restaurant_id, presence: true
  validates :user_id, presence: true
  validates :dine_at, presence: true
  validates :people, presence: true
  

end
