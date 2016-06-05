class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags
    set_meta_tags build_meta_options
  end

  def build_meta_options
    site_name = "시민 입법 프로젝트"
    title = "시민 입법 프로젝트 '버글시민 와글입법'"
    image = view_context.image_url('seo.png')
    url = 'http://up.parti.xyz'

    description = "2016년, 시민이 올리는 시민의 법안을 만들자!"
    {
      title:       title,
      reverse:     true,
      image:       image,
      description: description,
      keywords:    "빠띠, 한겨레21, 국범근, 쥐픽쳐스, 정치, 법률, 입법, 시민, 최저임금 1만원법, 전월세, 전월세 상한제법, 데이트폭력, 데이트폭력 처벌강화법, GMO, GMO 완전표시제법",
      canonical:   url,
      og: {
        url: url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }
  end
end
