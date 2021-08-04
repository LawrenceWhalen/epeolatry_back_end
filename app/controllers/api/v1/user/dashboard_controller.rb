class Api::V1::User::DashboardController < ApplicationController
  def show
    # user_glossaries = Glossary.word_stats(params[:user_id])
    #   word_array = user_glossaries.map do |gloss|
    #     Word.find(gloss[:word_id])
    #   end
    word_ids = Glossary.users_words(params[:user_id])
    words = Word.find(word_ids)
    list = []
    words.map do |word|
      list << word[:word]
    end
    longest_word = list.sort {|l, r| r.length <=> l.length}.first
    render json: DashboardSerializer.word_stats(longest_word)
  end
end
# def index
#   word_ids = Glossary.users_words(params[:user_id])
#   words = Word.find(word_ids)
#   render json: WordSerializer.new(words)
# end
