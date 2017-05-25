class Restaurant < ApplicationRecord

  # has_many :administrators
  has_many :tables
  has_many :users
  has_many :reservations, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :guests, :dependent => :destroy, class_name: "User", through: :reservations
  # has_many :reviews, :dependent => :destroy, inverse_of: :Reservation
  has_many :reviewers, :dependent => :destroy, class_name: "User"

  validates :name, presence: true
  validates :address, presence: true
  # validates :table_number, presence: true
  # validates :table_number, :inclusion => 1..10

end
