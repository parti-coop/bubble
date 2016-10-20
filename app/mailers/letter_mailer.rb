class LetterMailer < ApplicationMailer
  def memorial_email(to_email, to_name, to_party, from_email, from_name, title)
    @from_name = from_name
    @from_email = from_email
    @to_email = to_email
    @to_name = to_name
    @to_party = to_party
    mail(to: to_email, reply_to: from_email, subject: title)
  end
end
