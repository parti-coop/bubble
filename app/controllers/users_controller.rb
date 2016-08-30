class UsersController < ApplicationController
  def card
    @user = User.find(params[:id])
    image = user_card_url(@user, format: :png)
    prepare_meta_tags url: root_url, image: image

    respond_to do |format|
      format.png do
        if params[:no_cached]
          send_data(render_card, :type => "image/png", :disposition => 'inline')
        else
          if !@user.card.file.try(:exists?) or (params[:update] and current_user.try(:admin?))
            file = Tempfile.new(["card_#{@user.id.to_s}", '.png'], 'tmp', :encoding => 'ascii-8bit')
            file.write render_card
            file.flush
            @user.card = file
            @user.save
            file.unlink
          end
          send_file(@user.card.path, :type => "image/png", :disposition => 'inline')
        end
      end
      format.html {
        redirect_to(params[:redirect_to] || root_path) and return unless browser.bot?
        render(layout: nil)
      }
    end
  end

  private

  def render_card
    IMGKit.new(render_to_string(layout: nil), width: 1200, height: 630, quality: 10).to_png
  end
end


def destroy
  @note.try(:destroy)
  redirect_to issue_notes_path(@note.issue)
end
