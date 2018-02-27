class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.present? && record.quantity.present?
    if record.start_date > record.end_date
      record.errors[:base] << I18n.t('tempbook.errorfd')
    end
    if record.start_date < Time.now
      record.errors[:base] << I18n.t('tempbook.errorpast')
    end
    if record.quantity > record.tool.quantity
      record.errors[:base] << "Non puoi prenotare più strumenti di quanti effettivamente ce ne sono"
    end
    if record.quantity < 0
      record.errors[:base] <<I18n.t('tools.quantity')
    end
    end
  end
end

class Tempbook < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :quantity, presence: true, format: { with: /([1-9]+)/}
  belongs_to :tool
  belongs_to :prof
  validates_with MyValidator
end
