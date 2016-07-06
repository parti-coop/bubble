class PagesController < ApplicationController
  def home
    @posts = Post.recent.in_party_building_board.search_for(params[:q]).page(params[:page])
    @user = current_user
  end

  def step1
    @posts = Post.recent.in_bill_choice_board.search_for(params[:q]).page(params[:page])
  end
end
