class Photo < ApplicationRecord
  validates :picture, presence: true
  mount_uploader :picture, PhotoUploader
  belongs_to :tool
  belongs_to :request
  validates_associated :tool, :message => "You have already too much things."
end
