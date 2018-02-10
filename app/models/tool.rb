class Tool < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PhotoUploader
  translates :name, :string, uniqueness: true
  translates :description, :string
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  validates :days, presence: true
  has_and_belongs_to_many :labs
  has_and_belongs_to_many :categories
  paginates_per 7
end
