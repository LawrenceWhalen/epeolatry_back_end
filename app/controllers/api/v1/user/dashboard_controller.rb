class Api::V1::User::DashboardController < ApplicationController
  def show
    dash_word_specs = DashboardFacade.word_stats(params[:user_id])
    render json: DashboardSerializer.word_stats(dash_word_specs)
  end
end
