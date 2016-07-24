%w(overall_adoption non_gmo exemption_range).each do |slug|
  Debate.seed_once(:slug) do |s|
    s.slug = slug
  end
end
