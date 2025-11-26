class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, presence: true
  validates :total, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "subtotal", "gst_total", "pst_total", "hst_total", "total", "status", "user_id", "address_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "address", "order_items", "products" ]
  end
end
