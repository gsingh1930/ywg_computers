class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "description", "stock_quantity", "unit_price", "category_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "order_items", "orders" ]
  end
end
