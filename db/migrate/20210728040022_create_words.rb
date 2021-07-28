class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :word
      t.string :definition
      t.string :example
      t.string :part_of_speech
      t.string :synonyms
      t.string :language

      t.timestamps
    end
  end
end
