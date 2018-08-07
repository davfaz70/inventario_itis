class RequestValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity.present?
      if record.quantity < 0
        record.errors[:base] << I18n.t('tools.quantity')
      end
    end
    if record.money == true && record.approved == false
      record.errors[:base] << I18n.t('request.notmoney')
    end
    if record.arrived == true && (record.approved == false || record.money == false)
      record.errors[:base] << I18n.t('request.notarrived')
    end
  end
end

class Request < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
  validates :name, presence: true
  validates :description, presence: true
  validates :goal, presence: true
  validates :quantity, presence: true, format: {with: /([0-9]+)/}
  has_many :documentations, dependent: :destroy
  accepts_nested_attributes_for :documentations, allow_destroy: true
  has_many :photos, dependent: :destroy
  validates_each :photos do |tool, attr, value|
   tool.errors.add attr, I18n.t('.tools.photos') if tool.photos.size > 4
  end
  accepts_nested_attributes_for :photos, allow_destroy: true
  has_and_belongs_to_many :categories
  belongs_to :prof
  belongs_to :technical
  before_save :name
  validates_with RequestValidator
  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
end
