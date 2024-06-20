
module Users
  class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
      begin
        ActiveRecord::Base.transaction do
          if @comment.save
            render json: { success: true, user_name: @comment.user.name, content: @comment.content }
          else
            render json: { success: false, errors: @comment.errors.full_messages }
          end
        end
      rescue ActiveRecord::StatementInvalid => e
        if e.message.include?("database is locked")
          sleep 0.1
          retry
        else
          raise e
        end
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@comment.post) }
        format.json { render json: { success: true } }
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
