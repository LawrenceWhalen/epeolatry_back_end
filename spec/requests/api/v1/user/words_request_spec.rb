require 'rails_helper'

RSpec.describe 'Words Request' do
  it 'can show all of a user\'s words' do
    get api_v1_user_words_path

    words = JSON.parse(response.body, symbolize_names: true)

    
  end
end
