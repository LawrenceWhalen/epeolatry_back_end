class AlertPoro
  attr_reader :alert,
              :id

  def initialize(info)
    @alert = info[:alert]
    @id = info[:id]
  end
end