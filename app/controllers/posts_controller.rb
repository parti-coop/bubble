class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post.recent.page(params[:page])
  end

  def create
    @post.user = current_user if user_signed_in?
    @post.save if verify_recaptcha(model: @post) or user_signed_in?

    if @post.board_slug == Post::BOARD_SLUG_BILL_CHOICE
      redirect_to step1_path(anchor: 'posts-anchor')
    else
      redirect_to root_path(anchor: 'posts-anchor')
    end
  end

  def update
    @post.assign_attributes(post_params)
    if @post.save
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.try(:destroy)
    redirect_to root_path(anchor: 'posts-anchor')
  end

  def upvote
    if user_signed_in?
      @post.upvote(current_user)
      @post.save
      redirect_to @post
    else
      redirect_to new_user_registration_path(redirect_to: post_path(@post))
    end
  end

  def unvote
    if user_signed_in?
      @post.upvotes.find_by(user: current_user).destroy
      redirect_to @post
    else
      redirect_to new_user_registration_path(redirect_to: post_path(@post))
    end
  end

  private

  def post_params
    params.require(:post).permit(:guest_email, :guest_name, :title, :body, :board_slug)
  end
end
