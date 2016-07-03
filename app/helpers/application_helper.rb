module ApplicationHelper
  def date_f(date)
    if date.today?
      date.strftime("%H:%M")
    else
      date.strftime("%Y-%m-%d")
    end
  end

  def bill_upvoted?(bill)
    voted_bills.include? bill.id
  end

  def bill_mark_upvoted(bill)
    cookies.permanent.signed[:qus_qus] = JSON.generate(voted_bills << bill.id)
  end

  def party_name_upvoted?(party_name = nil)
    if party_name.nil?
      voted_party_name.present?
    else
      voted_party_name == party_name.slug
    end
  end

  def party_name_mark_upvoted(party_name)
    cookies.permanent.signed[:berry_berry] = party_name.slug
  end

  def image_base64(path)
    content, content_type = parse_image(path)
    base64 = Base64.encode64(content).gsub(/\s+/, "")
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def asset_data_base64(path)
    content, content_type = parse_asset(path)
    base64 = Base64.encode64(content).gsub(/\s+/, "")
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  private

  def voted_bills
    cookie_voted_bills = cookies.permanent.signed[:qus_qus]
    voted_bills = []
    if cookie_voted_bills.present?
      voted_bills = JSON.parse(cookie_voted_bills)
    end
    voted_bills
  end

  def voted_party_name
    cookies.permanent.signed[:berry_berry].presence
  end

  def parse_image(path)
    content_type = MIME::Types.type_for(path).first.content_type
    content = open(path).read
    return content, content_type
  end

  def parse_asset(path)
    if Rails.application.assets
      asset = Rails.application.assets.find_asset(path)
      throw "Could not find asset '#{path}'" if asset.nil?
      return asset.to_s, asset.content_type
    else
      name = Rails.application.assets_manifest.assets[path]
      throw "Could not find asset '#{path}'" if name.nil?
      content_type = MIME::Types.type_for(name).first.content_type
      content = open(File.join(Rails.public_path, 'assets', name)).read
      return content, content_type
    end
  end

  def videos_urls
    %w(https://www.youtube.com/watch?v=zdtN1zYfiG0 https://youtu.be/fh-uDxgawEU https://youtu.be/fh-uDxgawEU)
  end

  def video_titles
    [raw('4대 법안<br class="hidden-sm">소개'), raw('시민입법<br class="hidden-sm"> 취지 소개'), raw('<span style="white-space: nowrap">프로젝트 정당</span><br class="hidden-sm"> 만들기')]
  end

  def mask_name(name)
    return name if name.blank? or name.length == 1
    name.length > 6 ? name[0...-3] + "***" : name[0...-1] + "*"
  end

end
