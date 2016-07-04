class PagesController < ApplicationController
  def home
    @posts = Post.recent.in_party_building_board.page(params[:page])
    @user = current_user
  end

  def step1
    @posts = Post.recent.in_bill_choice_board.page(params[:page])
  end
end
