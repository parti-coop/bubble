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
end
