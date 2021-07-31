class CreateVocabulary < ActiveRecord::Migration[5.2]
  def change
    create_table :vocabularies do |t|
      t.integer :book_id
      t.integer :user_id
      t.references :word, foreign_key: true

      t.timestamps
    end
  end
end
