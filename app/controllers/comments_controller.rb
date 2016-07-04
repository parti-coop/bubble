class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment.user = current_user if user_signed_in?
    @comment.save if verify_recaptcha(model: @comment) or user_signed_in?
    redirect_to @comment.post
  end

  def update
    @comment.assign_attributes(comment_params)
    if @comment.save
      redirect_to @comment.post
    else
      render 'edit'
    end
  end

  def destroy
    @comment.try(:destroy)
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :guest_email, :guest_name, :body)
  end
end
