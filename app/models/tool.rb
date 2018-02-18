class Tool < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
  translates :name, :description
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true, format: {with: /\d/}
  validates :days, presence: true, format: {with: /\d/}
  has_and_belongs_to_many :labs
  has_and_belongs_to_many :categories
  has_many :tempbooks
  has_many :books
  paginates_per 4
end
