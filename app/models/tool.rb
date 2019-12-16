class ToolValidator < ActiveModel::Validator
  def validate(record)

    if record.identifier.present? && record.labs.size > 1
        record.errors[:base] << I18n.t('tools.identifier')
    end
    if record.identifier.present? && record.labs_tools.size == 1
      if record.labs_tools.first.quantity > 1
        record.errors[:base] << I18n.t('tools.identifier')
      end
    end
    if record.identifier.present? && record.labs_tools.size > 1
      record.errors[:base] << I18n.t('tools.identifier')
    end

    if record.labs_tools.size > 1
      lab = []
      for l in record.labs_tools
        lab.push(l.lab_id)
      end

      if lab.uniq.length != lab.length
        record.errors[:base] << I18n.t('tools.labs')
      end
    end

  end
end

class Tool < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  translates :name, :description
  validates :name, presence: true
  validates :identifier, uniqueness: true, :allow_blank => true
  validates :description, presence: true

  has_many :labs_tools, dependent: :destroy
  has_many :labs, through: :labs_tools
  accepts_nested_attributes_for :labs_tools, allow_destroy: true
  has_and_belongs_to_many :categories
  has_many :tempbooks
  has_many :books, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :reportings, dependent: :destroy
  has_many :documentations, dependent: :destroy
  accepts_nested_attributes_for :documentations, allow_destroy: true
  has_many :photos, dependent: :destroy
  validates_each :photos do |tool, attr, value|
   tool.errors.add attr, I18n.t('.tools.photos') if tool.photos.size > 4
  end
  accepts_nested_attributes_for :photos, allow_destroy: true
  before_save :name

#  default_scope -> {order(name: :asc)}
  #default_scope with_translations.order("name ASC")

  validates_with ToolValidator
  paginates_per 12

  def name=(s)
    write_attribute(:name, s.to_s.capitalize)
  end
  def self.with_translated_name(name_string)
  with_translations(I18n.locale).where('tool_translations.name' => name_string)
  end


  private

def self.ransackable_scopes(auth_object = nil)
  %i(with_translated_name)
end

end
