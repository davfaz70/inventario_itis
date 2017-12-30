class Tool < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_and_belongs_to_many :students

end
