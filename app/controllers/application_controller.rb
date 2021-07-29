class ApplicationController < ActionController::API

  private

  def pageination(page = 1)
    if page == '0' || page.to_i <= 0
      0
    else
      (page.to_i - 1) * 10
    end
  end
  
end
