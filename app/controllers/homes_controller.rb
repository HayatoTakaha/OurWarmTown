class HomesController < ApplicationController
  def top
    @groups = Group.includes(:posts).page(params[:group_page]).per(8)
    @recent_posts = Post.order(created_at: :desc).page(params[:post_page]).per(8)
  end
end
