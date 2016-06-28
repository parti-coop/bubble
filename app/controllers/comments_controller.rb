class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save if verify_recaptcha(model: @comment)
    redirect_to @comment.post
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :email, :name, :body)
  end
end
