class Lab < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :subject, presence: true
  has_and_belongs_to_many :tools
  
  paginates_per 5
  before_save :name
  before_save :subject
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
  def subject=(s)
    write_attribute(:subject, s.to_s.capitalize)
  end
end
