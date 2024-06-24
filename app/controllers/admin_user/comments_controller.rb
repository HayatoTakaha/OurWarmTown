# app/controllers/admin_user/comments_controller.rb
class AdminUser::CommentsController < ApplicationController
  layout 'admin'

  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントが削除されました。' 
  end
end
