class CreateTranslationTableToTools < ActiveRecord::Migration[5.0]
  def self.up
      Tool.create_translation_table!({
        :name => :string,
        :description => :string
      }, {
        :migrate_data => true,
        :remove_source_columns => true
      })
    end

    def self.down
      Tool.drop_translation_table! :migrate_data => true
    end
end
