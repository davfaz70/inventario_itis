class LabToolValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity.present?
      if record.quantity <= 0
        record.errors[:base] << I18n.t('tools.quantity')
      end
    end
  end
end

class LabsTool < ApplicationRecord

  belongs_to :lab
  belongs_to :tool
  validates :quantity, presence: true, format: {with: /([0-9]+)/}
  validates :lab_id, uniqueness: { scope: :tool_id }

  validates_with LabToolValidator
end
