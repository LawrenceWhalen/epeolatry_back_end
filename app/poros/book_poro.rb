class BookPoro
  attr_reader :title,
              :authors,
              :description,
              :genres,
              :g_id,
              :shelves

  def initialize(attributes)
    @g_id = attributes[:id] if attributes[:id]
    @title = attributes[:volumeInfo][:title] if attributes[:volumeInfo][:title]
    @authors = attributes[:volumeInfo][:authors] if attributes[:volumeInfo][:authors]
    @genres = attributes[:volumeInfo][:categories] if attributes[:volumeInfo][:categories]
    @description = attributes[:volumeInfo][:description] if attributes[:volumeInfo][:description]
    @shelves = nil
  end
end
