class Order < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :subtotal, presence: true
  validates :total, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id subtotal gst_total pst_total hst_total total status user_id address_id created_at
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user address order_items products]
  end
end
