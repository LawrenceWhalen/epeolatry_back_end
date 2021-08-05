class BookPoro
  attr_reader :title,
              :authors,
              :description,
              :genres,
              :g_id,
              :shelves

  def initialize(attributes)
    @g_id = attributes[:id]
    @title = attributes[:volumeInfo][:title]
    @authors = attributes[:volumeInfo][:authors]
    @genres = attributes[:volumeInfo][:categories]
    @description = attributes[:volumeInfo][:description]
    @shelves = nil
  end
end
