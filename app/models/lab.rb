class Lab < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true, uniqueness: true
  validates :subject, presence: true
  has_many :labs_tools
  has_many :tools, through: :labs_tools
  has_many :lab_technicals
  has_many :technicals, through: :lab_technicals
  has_many :tempbooks
  has_many :books, dependent: :destroy
  has_many :reportings, dependent: :destroy
  accepts_nested_attributes_for :labs_tools

  paginates_per 24
  before_save :name
  before_save :subject
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
  def subject=(s)
    write_attribute(:subject, s.to_s.capitalize)
  end
end
