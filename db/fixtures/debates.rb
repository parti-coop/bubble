%w(overall_adoption non_gmo).each do |slug|
  Debate.seed_once(:slug) do |s|
    s.slug = slug
  end
end
