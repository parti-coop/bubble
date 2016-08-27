class PagesController < ApplicationController
  def home
    @user = current_user
  end

  def step1
    @posts = Post.recent.in_bill_choice_board.search_for(params[:q]).page(params[:page])

    render layout: 'retired'
  end

  def step2
    @user = current_user
    @board_slug = params[:board_slug] || Post::BOARD_SLUG_PARTY_BUILDING
    @posts = Post.recent.in_party_building_board.search_for(params[:q]).page(params[:page])

    render layout: 'retired'
  end

  def step3
    @board_slug = params[:board_slug] || Post::BOARD_SLUG_PARTY_SUGGEST
    @posts = Post.recent.in_board(@board_slug).search_for(params[:q]).page(params[:page])
    @user = current_user

    @overall_adoption_debate = Debate.find_by slug: 'overall_adoption'
    @non_gmo_debate = Debate.find_by slug: 'non_gmo'
    @exemption_range_debate = Debate.find_by slug: 'exemption_range'

    render layout: 'retired'
  end
end
