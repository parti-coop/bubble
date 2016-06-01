module ApplicationHelper
  def upvoted?(bill)
    voted_bills.include? bill.id
  end

  def mark_upvoted(bill)
    cookies.signed[:qus_qus] = JSON.generate(voted_bills << bill.id)
  end

  private

  def voted_bills
    cookie_voted_bills = cookies.signed[:qus_qus]
    voted_bills = []
    if cookie_voted_bills.present?
      voted_bills = JSON.parse(cookie_voted_bills)
    end
    voted_bills
  end
end
