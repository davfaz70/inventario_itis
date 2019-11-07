class LabsTool < ApplicationRecord
  belongs_to :lab
  belongs_to :tool
  validates :quantity, presence: true, format: {with: /([0-9]+)/}
  validates :lab_id, uniqueness: { scope: :tool_id }
end
