class SerializableBookPoro < JSONAPI::Serializable::Resource
  type 'book_poros'
  id { @object.g_id }
  attributes :title, :authors, :genres, :description

end