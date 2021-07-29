require 'rails_helper'

RSpec.describe BookSerializer do
  describe 'creation' do
    it 'creates the expected attributes' do
      actual = BookSerializer.new(create(:book_poro))

      expect(actual.attributes.keys).
      to contain_exactly(
        :g_id,
        :title,
        :authors,
        :genres,
        :description
      )

    end
  end
end