class AdminValidator < ActiveModel::Validator
  def validate(record)

    if Admin.exists?(role: 0) && record.role == 0
      if record.email != Admin.where("role = 0").first.email
        record.errors[:base] << I18n.t('admins.schoolauthority')
      end
    elsif Admin.exists?(role: 1) && record.role == 1
      if record.email != Admin.where("role = 1").first.email
        record.errors[:base] << I18n.t('admins.dsga')
      end
    elsif Admin.exists?(role: 2) && record.role == 2
      if record.email != Admin.where("role = 2").first.email
        record.errors[:base] << I18n.t('admins.ata')
      end
    end

    if record.agree == false
      record.errors[:base] << I18n.t('devise.agree')
    end

  end
end
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         validates_with AdminValidator
end
