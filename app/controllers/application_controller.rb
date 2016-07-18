class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"
  after_filter :prepare_unobtrusive_flash

  if Rails.env.production? or Rails.env.staging?
    rescue_from ActiveRecord::RecordNotFound do |exception|
      render_404
    end
    rescue_from CanCan::AccessDenied do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => exception.message
    end
    rescue_from ActionController::InvalidCrossOriginRequest, ActionController::InvalidAuthenticityToken do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => I18n.t('errors.messages.invalid_auth_token')
    end
  end

  def render_404
    self.response_body = nil
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def prepare_meta_tags(options={})
    set_meta_tags build_meta_options(options)
  end

  def build_meta_options(options)
    site_name = "시민 입법 프로젝트"
    title = "시민 입법 프로젝트 '바글시민 와글입법 두 번째 프로젝트'"
    image = options[:image] || view_context.image_url('step2/seo-quiz.png')
    url = options[:url] || root_url

    description = "'바글시민 와글입법' 시민입법프로젝트 정당 만들기. GMO완전표시제 입법을 위한 ‘나는 알아야겠당' 당원가입하고 OX퀴즈 풀자!"
    {
      title:       title,
      reverse:     true,
      image:       image,
      description: description,
      keywords:    "빠띠, 한겨레21, 정치, 법률, 입법, 시민, GMO, GMO 완전표시제법, 디지털 민주주의",
      canonical:   url,
      twitter: {
        site_name: site_name,
        site: '@parti_xyz',
        card: 'summary',
        title: title,
        description: description,
        image: image
      },
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

  def after_sign_in_path_for(resource)
    redirect_to = request.env["omniauth.params"].try(:fetch, "redirect_to", nil)
    redirect_to || stored_location_for(resource) || root_path
  end
end
