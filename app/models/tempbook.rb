class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.sd > record.fd
      record.errors[:base] << "La data di inizio deve essere prima di quella di fine, lo sanno anche i bambini"
    end
    if record.sd < Time.now
      record.errors[:base] << "Non puoi prenotare uno strumento nel passato"
    end
  end

end

class Tempbook < ApplicationRecord
  validates :prof, presence: true
  validates :prof_email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  validates :prof_surname, presence: true
  validates :sd, presence: true
  validates :fd, presence: true
  validates_with MyValidator
  before_save   :downcase_email

  belongs_to :tool

  def downcase_email
     self.prof_email = prof_email.downcase
   end
end
