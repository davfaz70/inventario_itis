class Post < ApplicationRecord
  validates :body, presence: true
  belongs_to :tool
  belongs_to :prof
  default_scope -> {order(created_at: :desc)}
end
