class MyValidator < ActiveModel::Validator
  def validate(record)
    if (record.identifier != nil) && (record.quantity > 1)
      record.errors[:base] << I18n.t('tools.identifier')
      record.quantity = 1
      record.identifier = nil
    end
    if record.quantity < 0
      record.errors[:base] << I18n.t('tools.quantity')
    end
  end
end

class Tool < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
  translates :name, :description
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true, format: {with: /\d/}
  has_and_belongs_to_many :labs
  has_and_belongs_to_many :categories
  has_many :tempbooks
  has_many :books, dependent: :destroy
  before_save :name
  before_save :description
  validates_with MyValidator
  paginates_per 4

  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
  def description=(s)
    write_attribute(:description, s.to_s.capitalize)
  end
end
