class BookPoro
  attr_reader :title,
              :authors,
              :description,
              :genres,
              :g_id

  def initialize(attributes)
    @g_id = attributes[:id]
    @title = attributes[:volumeInfo][:title]
    @authors = attributes[:volumeInfo][:authors]
    @genres = attributes[:volumeInfo][:categories]
    @description = attributes[:volumeInfo][:description]
  end
end
