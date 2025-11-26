class Address < ApplicationRecord
  belongs_to :province
  belongs_to :user

  validates :street, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "street", "city", "postal_code", "province_id", "user_id", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "province", "user" ]
  end
end
