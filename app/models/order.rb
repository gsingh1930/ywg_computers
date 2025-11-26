class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, presence: true
  validates :total, presence: true
end
