class Book < ApplicationRecord
  belongs_to :tool
  belongs_to :prof
  belongs_to :lab
  default_scope -> {order(created_at: :desc)}
end
