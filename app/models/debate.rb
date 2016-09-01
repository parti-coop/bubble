class Debate < ActiveRecord::Base
  CHOICE_LABEL = {
    'overall_adoption' => {
      alpha: '단계적 시행',
      beta: '전면적 시행',
      title: '1. GMO 완전표시제 시행 시기는?',
      body: ''
    },
    'non_gmo' => {
      alpha: '표시 할 필요 없다 ',
      beta: '표시를 허용해야 한다',
      title: '2. GMO 표시 대상이 아닌 국내산 농산물에<br class="hidden-xs">Non-GMO(비GMO)라 표시해도 될까?',
      body: '세계적으로 상용화한 식용 GMO는 총 18개(지난해 말 기준). 이 중 국내로 들어오고 있는 GMO는 콩(대두)·옥수수·사탕무·카놀라(유채)·면화·알파파 등 6개 품목임. 이들 6개 품목은 의무적으로 GMO라고 표시해야 함. 그러나 국내산 콩, 국내산 옥수수처럼 ‘GMO로 수입되는 6개 품목에 포함되지만 GMO가 아닌 국내산 농산물’에‘Non-GMO’, ‘GMO-Free’을 표시하는 기준은 현행법에 없음. 이에 식품의약품안전처는 국내산 콩, 국내산 옥수수 등 6개 품목에 대해서만 제한적으로‘Non-GMO’를 허용하는 고시를 추진중. 그러나 생활협동조합이나 소비자단체 등에선 국내로 수입이 허용되는 6개 품목 뿐 아니라 전세계적으로 식용으로 쓰는 18개 GMO 품목 전부에 대해서 이에 해당하는 국내산 농산물에 민간이 자율적으로‘Non-GMO’, ‘GMO-Free’표시를 할 수 있도록 해야한다고 주장. 즉 GM가지와 구별되도록 국내산 가지에 ‘Non-GMO’표시를 허용하자는 것. GM가지는 국내로는 수입되지 않지만 전세계적으로는 상용화 돼 있고, 혹시나 국내로 수입되는 가공식품에 섞여 들어올 수도 있으니 ‘Non-GMO 가지’표시로 소비자의 불안을 없애줘야 한다는 취지.'
    },
    'exemption_range' => {
      alpha: '면제하지 말자(0%)',
      beta: '0.9%까지 면제',
      title: '3. GMO 표시 면제 범위는?',
      body: '현재 ‘비의도적 혼입치’는 3%. 유통 과정에서 의도치 않게 GMO가 섞였다고 보고 입혼 비율 3%까지는 표시를 면제해주는 제도.'
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

  def hold_label
    "모르겠습니다"
  end

  def title
    Debate::CHOICE_LABEL[slug][:title]
  end

  def body
    Debate::CHOICE_LABEL[slug][:body]
  end
end
