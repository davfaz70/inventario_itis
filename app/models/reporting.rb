class ReportValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity.present?
      if record.quantity > record.tool.quantity
        record.errors[:base] << "Non possono esserci più oggetti guasti di quanti sono effetivamente presenti"
      end
    end
  end
end
class Reporting < ApplicationRecord
  validates :description, presence: true
  validates :quantity, presence: true
  belongs_to :tool
  belongs_to :technical
  belongs_to :lab
end
