class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :unit_price, presence: true

  def item_total
    unit_price * quantity
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id quantity unit_price order_id product_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
