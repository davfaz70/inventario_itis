class Documentation < ApplicationRecord
  validates :name, presence: true
  validates :file, presence: true
  mount_uploader :file, FileUploader
  belongs_to :tool
end
