class PagesController < ApplicationController
  def home
    @comments = Comment.all.page(params[:page])
  end
end
