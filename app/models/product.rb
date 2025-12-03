class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags

  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
  validates :stock_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where(created_at: 3.days.ago..) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name description stock_quantity unit_price category_id on_sale sale_price created_at
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[category order_items orders image_attachment image_blob product_tags tags]
  end
end
