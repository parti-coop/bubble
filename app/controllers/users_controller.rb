class UsersController < ApplicationController
  def card
    @user = User.find(params[:id])
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
      format.html { render(layout: nil) }
    end
  end

  private

  def render_card
    IMGKit.new(render_to_string(layout: nil), width: 1200, height: 630, quality: 10).to_png
  end
end
