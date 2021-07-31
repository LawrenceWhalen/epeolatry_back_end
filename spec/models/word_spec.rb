require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'relationships' do
    it { should have_many(:glossaries) } 
  end

  # before :each do
  #
  # end
  #
  # describe 'class methods' do
  #   describe '.' do
  #   end
  # end
  #
  # describe 'instance methods' do
  #   describe '#' do
  #   end
  # end
end
