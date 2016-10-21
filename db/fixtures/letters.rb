if Letter.first.blank?
  Letter.seed do |s|
    s.send_count = 0
  end
end
