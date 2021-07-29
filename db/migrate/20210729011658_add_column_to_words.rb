class AddColumnToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :phonetic, :string
  end
end
