class Administrator < ApplicationRecord

  has_many :restaurants
  has_many :openhours
  has_many :tables

  validates :name, presence: true
  validates :password, presence: true
  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true
  # validates :password, confirmation: { case_sensitive: false }
  
  
end
