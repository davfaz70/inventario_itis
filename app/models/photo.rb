class Photo < ApplicationRecord
  validates :picture, presence: true
  mount_uploader :picture, PhotoUploader
  belongs_to :tool, optional: true
  belongs_to :request, optional: true
  validates_associated :tool, :message => "You have already too much things."
end
