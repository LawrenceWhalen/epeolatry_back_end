require 'rails_helper'

RSpec.describe Glossary, type: :model do
  describe 'relationships' do
    it { should belong_to(:word) }
  end
  #
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
