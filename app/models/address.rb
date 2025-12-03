class Address < ApplicationRecord
  belongs_to :province
  belongs_to :user

  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id street city postal_code province_id user_id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[province user]
  end
end
