class Review < ApplicationRecord

	belongs_to :restaurant
	belongs_to :reviewer, class_name: 'User', foreign_key: 'user_id'
	belongs_to :reservation

	validates :reservation, presence: true
	validates :content, presence: true


end
