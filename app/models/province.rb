class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates :abbreviation, presence: true
end
