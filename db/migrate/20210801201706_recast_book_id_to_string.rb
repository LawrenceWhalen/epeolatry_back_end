class RecastBookIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column(:glossaries, :book_id, :string)
  end
end
