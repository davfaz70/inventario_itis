class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :tool
  belongs_to :prof
end
