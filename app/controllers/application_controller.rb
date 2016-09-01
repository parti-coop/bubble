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
    site_name = "나는 알아야겠당"
    title = "시민 입법 프로젝트: 나는 알아야겠당"
    image = options[:image] || view_context.image_url('step3/seo-2.png')
    url = options[:url] || root_url

    description = "GMO완전표시제법 통과를 위한 국내 최초 온라인 프로젝트 정당 실험"
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

  helper_method :alpha_chosen?, :beta_chosen?, :hold_chosen?, :chosen?, :no_choice?

  private

  def errors_to_flash(model)
    flash[:notice] = model.errors.full_messages.join('<br>').html_safe
  end

  # choice

  def alpha_chosen?(slug)
    chosen?(slug, 'alpha')
  end

  def beta_chosen?(slug)
    chosen?(slug, 'beta')
  end

  def hold_chosen?(slug)
    chosen?(slug, 'hold')
  end

  def chosen?(slug, choice = nil)
    if choice == nil
      fetch_debate_choices[slug].present?
    else
      fetch_debate_choices[slug] == choice
    end
  end

  def fetch_debate_choices
    JSON.parse(cookies.permanent.signed[:kong_kong] || '{}')
  end

  def save_choice(slug, choice)
    debate_choices = fetch_debate_choices
    debate_choices[slug] = choice
    cookies.permanent.signed[:kong_kong] = JSON.generate(debate_choices)
  end

  def no_choice?(slug)
    debate_choices = fetch_debate_choices
    if debate_choices[slug] == 'hold'
      return true
    else
      return false
    end
  end
end
