class Table < ApplicationRecord

  belongs_to :restaurant

  validates :table_order, :inclusion => 1..10


end
