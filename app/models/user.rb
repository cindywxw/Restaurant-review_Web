class User < ApplicationRecord

  has_secure_password
  
  has_many :reservations
  has_many :reviews

  validates :name, presence: true
  validates :password, presence: true
  validates :email, presence: true
  validates :points, presence: true
  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  # validates :password, confirmation: { case_sensitive: false }
  
end
