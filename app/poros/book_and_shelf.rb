class BookAndShelf
  attr_reader :title,
              :authors,
              :description,
              :genres,
              :g_id,
              :shelves

  attr_writer :shelves

  def initialize(attributes)
    @g_id = attributes[:g_id]
    @title = attributes[:title]
    @authors = attributes[:authors]
    @genres = attributes[:genres]
    @description = attributes[:description]
    @shelves = attributes[:shelves]
  end

end
