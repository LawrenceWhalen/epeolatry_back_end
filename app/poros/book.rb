class Book
  attr_reader :title, 
              :authors, 
              :description, 
              :genres

  def initialize(attributes)
    @title = attributes[:title]
    @authors = attributes[:authors]
    @genres = attributes[:genres]
    @description = attributes[:description]
  end

end
