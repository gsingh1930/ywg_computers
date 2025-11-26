class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates :abbreviation, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "abbreviation", "gst", "pst", "hst", "created_at", "updated_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "addresses" ]
  end
end
