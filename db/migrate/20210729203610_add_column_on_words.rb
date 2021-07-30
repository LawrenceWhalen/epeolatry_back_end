class AddColumnOnWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :phonetic_link, :string
  end
end
