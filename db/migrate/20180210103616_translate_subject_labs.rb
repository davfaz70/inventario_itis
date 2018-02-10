class TranslateSubjectLabs < ActiveRecord::Migration[5.0]
  def self.up
    Lab.create_translation_table!({
      :subject => :string
    }, {
      :migrate_data => true,
      :remove_source_columns => true
    })
  end

  def self.down
    Lab.drop_translation_table! :migrate_data => true
  end
end
