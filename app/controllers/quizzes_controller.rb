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
    yes_setps = %w(1 3 5 7 9)
    @correct_count = answer_paper.select { |step, answer| yes_setps.include?(step) ? answer == 'yes' : answer == 'no' }.count
  end
end
