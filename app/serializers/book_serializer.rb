class BookSerializer < JSONAPI::Serializable::Resource
  type 'book_poros'

  attributes :g_id, :title, :authors, :genres, :description

end