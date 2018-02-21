class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.sd.present? && record.fd.present? && record.quantity.present?
    if record.sd > record.fd
      record.errors[:base] << I18n.t('tempbook.errorfd')
    end
    if record.sd < Time.now
      record.errors[:base] << I18n.t('tempbook.errorpast')
    end
    if record.quantity > record.tool.quantity
      record.errors[:base] << "Non puoi prenotare più strumenti di quanti effettivamente ce ne sono"
    end
    end
  end
end

class Tempbook < ApplicationRecord
  validates :prof, presence: true
  validates :prof_email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :prof_surname, presence: true
  validates :sd, presence: true
  validates :fd, presence: true
  validates :quantity, presence: true, format: { with: /([1-9]+)/}
  belongs_to :tool
  before_save   :downcase_email
  validates_with MyValidator

  def downcase_email
     self.prof_email = prof_email.downcase
   end


end
