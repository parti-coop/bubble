class PagesController < ApplicationController
  def home
    @board_slug = params[:board_slug] || Post::BOARD_SLUG_PARTY_SUGGEST
    @posts = Post.recent.in_board(@board_slug).search_for(params[:q]).page(params[:page])
    @user = current_user
  end

  def step1
    @posts = Post.recent.in_bill_choice_board.search_for(params[:q]).page(params[:page])
  end

  def step2
    @user = current_user
    @posts = Post.recent.in_party_building_board.search_for(params[:q]).page(params[:page])
  end
end
