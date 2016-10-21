if PetitionLetter.first.blank?
  PetitionLetter.seed do |s|
    s.send_count = 0
  end
end
