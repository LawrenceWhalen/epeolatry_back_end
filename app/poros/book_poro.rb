class BookPoro
  attr_reader :title, 
              :authors, 
              :description, 
              :genres,
              :g_id

  def initialize(attributes)
    @g_id = attributes[:g_id]
    @title = attributes[:title]
    @authors = attributes[:authors]
    @genres = attributes[:genres]
    @description = attributes[:description]
  end

end