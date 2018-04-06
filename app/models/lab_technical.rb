class LabTechValidator < ActiveModel::Validator
  def validate(record)
    if record.start_date.present? && record.end_date.present?
      if record.start_date > record.end_date
        record.errors[:base] << I18n.t('tempbook.errorfd')
      end
    end
    if record.start_date.present?
      if record.end_date.present? == false
        if record.start_date > Time.now
          record.errors[:base] << "Come fa ad essere attuale se la data di inizio è nel futuro?"
        end
      end
    end 
  end
end

class LabTechnical < ApplicationRecord
  belongs_to :lab
  belongs_to :technical
  validates :start_date, presence: true
  validates :lab_id, presence: true
  validates :technical_id, presence: true
  validates_with LabTechValidator

end
