require 'rails_helper'

RSpec.describe 'Book Poro' do
  it 'has attributes' do
    attributes =
    {
    id: '123',
    volumeInfo:
    {
      title: 'stinky cheese man',
      authors: ['Alex Smell', 'Wanda Feet'],
      description: 'A breathtaking book',
      categories: ['non-fiction']
      }
      }

    actual = BookPoro.new(attributes)

    expect(actual.g_id).to eq('123')
    expect(actual.title).to eq('stinky cheese man')
    expect(actual.authors).to eq(['Alex Smell', 'Wanda Feet'])
    expect(actual.description).to eq('A breathtaking book')
    expect(actual.genres).to eq(['non-fiction'])
  end
end
