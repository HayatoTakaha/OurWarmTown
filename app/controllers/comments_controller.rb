class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy if @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end