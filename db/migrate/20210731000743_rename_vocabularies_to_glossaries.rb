class RenameVocabulariesToGlossaries < ActiveRecord::Migration[5.2]
  def change
    rename_table :vocabularies, :glossaries
  end
end
