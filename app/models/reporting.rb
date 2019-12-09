class ReportValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity.present?
      if record.quantity > record.tool.labs_tools.where("lab_id=?", record.lab_id).first.quantity
        record.errors[:base] << "Non possono esserci più oggetti guasti di quanti sono effetivamente presenti"
      end
      if record.quantity < 0
        record.errors[:base] << I18n.t('tools.quantity')
      end
    end
  end
end
class Reporting < ApplicationRecord
  validates :description, presence: true
  validates :quantity, presence: true, format: {with: /([0-9]+)/}
  validates :tool_id, presence: true
  validates :lab_id, presence: true
  validates :technical_id, presence: true
  belongs_to :tool
  belongs_to :technical
  belongs_to :lab
  validates_with ReportValidator
end
