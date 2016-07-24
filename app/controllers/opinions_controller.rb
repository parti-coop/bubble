class OpinionsController < ApplicationController
  load_and_authorize_resource

  def index
    @debate = Debate.find_by slug: params[:debate_slug]
    @opinions = Opinion.in_debate(@debate).recent.page(params[:page])
  end

  def create
    @opinion.choice = fetch_debate_choices[@opinion.debate_slug]
    if verify_recaptcha(model: @opinion)
      errors_to_flash(@opinion) unless @opinion.save
    end
    redirect_to root_path(anchor: "opinion-anchor")
  end

  private

  def opinion_params
    params.require(:opinion).permit(:debate_slug, :name, :body)
  end
end

