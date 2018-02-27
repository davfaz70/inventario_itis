class Book < ApplicationRecord
  belongs_to :tool
  belongs_to :prof
  default_scope -> {order(created_at: :desc)}
end
