class Debate < ActiveRecord::Base
  CHOICE_LABEL = {
    'overall_adoption' => {
      alpha: '단계적 시행',
      beta: '전면적 시행'
    },
    'non_gmo' => {
      alpha: '표시 할 필요 없다 ',
      beta: '표시를 허용해야 한다'
    },
    'exemption_range' => {
      alpha: '면제하지 말자(0%)',
      beta: '0.9%까지 면제'
    }
  }

  def total_count
    alpha_count + beta_count
  end

  def alpha_percentage
    return 0 if alpha_count == 0
    (alpha_count / Float(total_count) * 100).round(2)
  end

  def beta_percentage
    return 0 if beta_count == 0
    (beta_count / Float(total_count) * 100).round(2)
  end

  def alpha_label
    Debate::CHOICE_LABEL[slug][:alpha]
  end

  def beta_label
    Debate::CHOICE_LABEL[slug][:beta]
  end
end
