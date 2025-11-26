class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "first_name", "last_name", "admin", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "addresses", "orders" ]
  end
end
