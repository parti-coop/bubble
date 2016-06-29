{
  ok: '건강하당', cosmos: '우주당', young: '영한당', tong: '통한당'
}.each do |slug, name|
  PartyName.seed_once(:slug) do |n|
    n.slug = slug
    n.name = name
  end
end
