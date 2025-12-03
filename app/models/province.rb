class Province < ApplicationRecord
  has_many :addresses, dependent: :nullify

  validates :name, presence: true
  validates :abbreviation, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name abbreviation gst pst hst created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['addresses']
  end
end
