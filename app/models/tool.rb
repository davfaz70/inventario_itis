class ToolValidator < ActiveModel::Validator
  def validate(record)
    if record.identifier.present? && record.quantity > 1
      record.errors[:base] << I18n.t('tools.identifier')
    end
    if record.quantity.present?
      if record.quantity < 0
        record.errors[:base] <<I18n.t('tools.quantity')
      end
    end
  end
end

class Tool < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  mount_uploader :photo, PhotoUploader
  process_in_background :photo
  default_scope -> {Tool.with_translations(I18n.locale)}
  translates :name, :description
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true, format: {with: /([0-9]+)/}
  has_and_belongs_to_many :labs
  has_and_belongs_to_many :categories
  has_many :tempbooks
  has_many :books, dependent: :destroy
  before_save :name
  before_save :description
  validates_with ToolValidator
  paginates_per 4

  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
  def description=(s)
    write_attribute(:description, s.to_s.capitalize)
  end
  def self.with_translated_name(name_string)
  with_translations(I18n.locale).where('tool_translations.name' => name_string)
  end

  private

def self.ransackable_scopes(auth_object = nil)
  %i(with_translated_name)
end

end
