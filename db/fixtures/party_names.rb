{
  bat: '박쥐당', know: '나는 알아야겠당', cosmos: '우주당', health: '건강하당'
}.each do |slug, name|
  PartyName.seed_once(:slug) do |n|
    n.slug = slug
    n.name = name
  end
end
