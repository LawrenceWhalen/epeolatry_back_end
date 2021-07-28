require 'rails_helper'

RSpec.describe 'book poro' do
  it 'has attributes' do
    not_harry_potter = Book.new(title: 'stinky cheese man')
  end
end
