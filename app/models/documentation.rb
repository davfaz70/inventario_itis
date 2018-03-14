class Documentation < ApplicationRecord
  validates :name, presence: true
  validates :file, presence: true
  belongs_to :tool
end
