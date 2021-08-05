class Api::V1::User::DashboardController < ApplicationController
  def show
    longest_word = Glossary.longest_word(params[:user_id])
    most_frequent = Glossary.most_frequent_word(params[:user_id])

    render json: DashboardSerializer.word_stats(most_frequent, longest_word)
  end
end
