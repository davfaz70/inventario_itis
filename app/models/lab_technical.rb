class LabTechValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.present?
      if record.start_date > record.end_date
        record.errors[:base] << I18n.t('tempbook.errorfd')
      end
    end
  end
end

class LabTechnical < ApplicationRecord
  belongs_to :lab
  belongs_to :technical
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates_with LabTechValidator

end
