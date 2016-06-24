class PagesController < ApplicationController
  def home
    @posts = Post.recent.page(1).per 3
  end

  def step1
    @comments = Comment.all.page(params[:page])
  end
end
