class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email first_name last_name admin created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[addresses orders]
  end
end
