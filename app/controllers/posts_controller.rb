class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.recent.page(params[:page])
  end

  def create
    @post.user = current_user if user_signed_in?
    @post.save if verify_recaptcha(model: @post) or user_signed_in?
    redirect_to root_path(anchor: 'post-form-anchor')
  end

  private

  def post_params
    params.require(:post).permit(:guest_email, :guest_name, :title, :body)
  end
end
