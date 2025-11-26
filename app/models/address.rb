class Address < ApplicationRecord
  belongs_to :province
  belongs_to :user

  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
end
