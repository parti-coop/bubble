class PagesController < ApplicationController
  def home
    @comments = Comment.all.page(params[:page]).per(3)
  end
end
