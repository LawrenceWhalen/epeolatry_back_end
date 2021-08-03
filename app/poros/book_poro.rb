class BookPoro
  attr_reader :title,
              :authors,
              :description,
              :genres,
              :id

  # def initialize(attributes)
  #   @g_id = attributes[:g_id]
  #   @title = attributes[:title]
  #   @authors = attributes[:authors]
  #   @genres = attributes[:genres]
  #   @description = attributes[:description]
  # end
  def initialize(attributes)
    @g_id = attributes[:id]
    @title = attributes[:volumeInfo][:title],
    @authors = attributes[:volumeInfo][:authors].to_s,
    @genres = attributes[:volumeInfo][:categories],
    @description = attributes[:volumeInfo][:description]
  end
end
