class PetitionLettersController < ApplicationController
  include LetterHelper

  def send_mail
    congressman = find_congressman params[:congressman]
    redirect_to letter_path and return if congressman.blank? or params[:name].blank? or params[:title].blank?

    LetterMailer.petition_email(congressman.email, congressman.name, congressman.party,
      params[:email], params[:name], params[:title]).deliver_later

    PetitionLetter.increase_send_count
    session[:last_letter_to] = congressman.id
    redirect_to letter_path, notice: "#{congressman.party} #{congressman.name} 의원님께 메일을 보냈습니다!"
  end
end
