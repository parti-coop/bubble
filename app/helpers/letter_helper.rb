module LetterHelper
  CONGRESSMEN = [
    %w(1 더불어민주당  인재근  ijgalso@daum.net),
    %w(2 새누리당  김상훈 kshdg11@gmail.com),
    %w(3 국민의당  김광수  ks-1958@naver.com),
    %w(4 새누리당  김승희  shkim2756@naver.com),
    %w(5 새누리당  박인숙  ispark0530@naver.com),
    %w(6 새누리당  성일종  sij5140@naver.com),
    %w(7 새누리당  송석준  icheonsarang734@assembly.co.kr),
    %w(8 더불어민주당  권미혁  kwonmh@na.go.kr),
    %w(9 더불어민주당  남인순  nisoon@na.go.kr),
    %w(10 더불어민주당  전혜숙  jhsook7612@gmail.com)
  ].map { |row| OpenStruct.new(id: row[0], party: row[1], name: row[2], email: row[3]) }

  def find_congressman(id)
    return LetterHelper::CONGRESSMEN.detect{|c| c.id == id}
  end
end