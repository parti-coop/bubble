[Bill::MINIMUM_WAGE, Bill::RENT_CEILING, Bill::DATE_VIOLENCE, Bill::GMO_MARK].each do |slug|
  Bill.seed_once(:slug) do |s|
    s.slug = slug
  end
end
