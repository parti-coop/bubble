class OpinionsController < ApplicationController
  load_and_authorize_resource

  def index
    if request.format == 'text/javascript'
      @debate = Debate.find_by slug: params[:debate_slug]
      @opinions = Opinion.in_debate(@debate).recent.page(params[:page])
    end

    respond_to do |format|
      format.js
      format.any { redirect_to root_path }
    end
  end

  def create
    @opinion.choice = fetch_debate_choices[@opinion.debate_slug]
    if verify_recaptcha(model: @opinion)
      errors_to_flash(@opinion) unless @opinion.save
    end
    redirect_to debates_path(anchor: "opinion-anchor-#{@opinion.debate_slug}")
  end

  private

  def opinion_params
    params.require(:opinion).permit(:debate_slug, :name, :body)
  end
end

