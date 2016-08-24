class PropositionsController < ApplicationController
  def show
    @proposition = (Proposition.find_by slug: params["slug"]) || Proposition.most_important
  end
end
