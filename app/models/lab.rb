class Lab < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  translates :subject, :string
  validates :name, presence: true, uniqueness: true
  validates :subject, presence: true
  has_and_belongs_to_many :tools
  paginates_per 5
end
