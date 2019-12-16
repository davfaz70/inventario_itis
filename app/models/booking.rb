class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.present? && record.quantity.present? && record.tool.present?
      if record.start_date > record.end_date
        record.errors[:base] << I18n.t('tempbook.errorfd')
      end
      if record.start_date < Time.now
        record.errors[:base] << I18n.t('tempbook.errorpast')
      end
      labq = record.tool.labs_tools.where("lab_id = ?", record.lab_id).first
      if record.quantity > labq.quantity
        record.errors[:base] << I18n.t('tempbook.plus')
      end
      if record.quantity < 0
        record.errors[:base] <<I18n.t('tools.quantity')
      end
    end
  end
end
class Booking < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :goal, presence: true
  validates :lab_id, presence: true
  validates :prof_id, presence: true
  validates :tool_id, presence: true
  validates :quantity, presence: true, format: { with: /([1-9]+)/}
  belongs_to :tool
  belongs_to :prof
  belongs_to :lab
  validates_with MyValidator
  default_scope -> {order(created_at: :desc)}
end
