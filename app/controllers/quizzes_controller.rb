class QuizzesController < ApplicationController

  YES_STEPS = %w(5 6)

  def result
    answer_paper = fetch_answer_paper
    answer_paper[params[:step]] = params[:answer]
    answer_paper_json = JSON.generate(answer_paper)
    cookies.signed[:muni_muni] = answer_paper_json
  end

  def report
    answer_paper = fetch_answer_paper
    @correct_count = answer_paper.select { |step, answer| QuizzesController::YES_STEPS.include?(step) ? answer == 'yes' : answer == 'no' }.count
  end

  CORRECT_COUNT_INDEX = 5

  def seo_report
    redirect_to(root_path) if params[:lulu].blank?
    redirect_to(root_path) and return unless browser.bot?
    prepare_meta_tags url: seo_report_quiz_url(lulu: params[:lulu]), image: view_context.image_url("step2/quiz-correct-count-#{params[:lulu][QuizzesController::CORRECT_COUNT_INDEX]}.png")
  end

  helper_method :seo_report_quiz_url_with_correct_count, :is_correct?
  private

  def seo_report_quiz_url_with_correct_count(correct_count)
    random_hex = SecureRandom.hex(10)
    random_hex[QuizzesController::CORRECT_COUNT_INDEX] = correct_count.to_s
    seo_report_quiz_url(lulu: random_hex)
  end

  def is_correct?(step)
    answer_of_current_step = fetch_answer_paper[step]
    answer_of_current_step == (QuizzesController::YES_STEPS.include?(step) ? 'yes' : 'no')
  end

  def fetch_answer_paper
    previous_answer_paper_json = cookies.signed[:muni_muni]
    JSON.parse(previous_answer_paper_json || '{}')
  end
end
