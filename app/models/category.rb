class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :requests
  before_save :name
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
end
