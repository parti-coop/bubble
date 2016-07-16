class QuizzesController < ApplicationController
  def result
    previous_answer_paper_json = cookies.signed[:muni_muni]
    answer_paper = JSON.parse(previous_answer_paper_json || '{}')
    answer_paper[params[:step]] = params[:answer]
    answer_paper_json = JSON.generate(answer_paper)
    cookies.signed[:muni_muni] = answer_paper_json
  end

  def report
    previous_answer_paper_json = cookies.signed[:muni_muni]
    answer_paper = JSON.parse(previous_answer_paper_json || '{}')
    yes_setps = %w(5 6)
    @correct_count = answer_paper.select { |step, answer| yes_setps.include?(step) ? answer == 'yes' : answer == 'no' }.count
  end

  CORRECT_COUNT_INDEX = 5

  def seo_report
    redirect_to(root_path) if params[:lulu].blank?
    redirect_to(root_path) and return unless browser.bot?
    prepare_meta_tags url: root_url, image: view_context.image_url("step2/quiz-correct-count-#{params[:lulu][QuizzesController::CORRECT_COUNT_INDEX]}.png")
  end

  helper_method :seo_report_quiz_url_with_correct_count
  private

  def seo_report_quiz_url_with_correct_count(correct_count)
    random_hex = SecureRandom.hex(10)
    random_hex[QuizzesController::CORRECT_COUNT_INDEX] = correct_count.to_s
    seo_report_quiz_url(lulu: random_hex)
  end
end
