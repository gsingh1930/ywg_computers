class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "quantity", "order_id", "product_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "order", "product" ]
  end
end
