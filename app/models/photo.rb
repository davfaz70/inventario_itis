class Photo < ApplicationRecord
  validates :picture, presence: true
  mount_uploader :picture, PhotoUploader
  belongs_to :tool
  validates_associated :tool, :message => "You have already too much things."
end
