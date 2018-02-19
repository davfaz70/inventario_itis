class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :tools
  before_save :name
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
end
