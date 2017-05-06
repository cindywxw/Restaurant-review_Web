class Restaurant < ApplicationRecord

  has_many :administrators
  has_many :tables
  has_many :reservations
  has_many :guests, class_name: "User", through: :reservations
  has_many :reviews

  # validates :table_number, presence: true
  # validates :table_number, :inclusion => 1..10

end
