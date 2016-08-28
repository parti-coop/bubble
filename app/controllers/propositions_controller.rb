class PropositionsController < ApplicationController
  def show
    @proposition = (Proposition.find_by slug: params["slug"]) || Proposition.most_important

    @proposition_comments=@proposition.comments.recent.page(params[:page]).per(15)
  end
end
