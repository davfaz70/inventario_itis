class Book < ApplicationRecord
  belongs_to :tool
  default_scope -> {order(created_at: :desc)}
end
