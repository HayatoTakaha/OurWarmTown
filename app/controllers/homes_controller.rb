class HomesController < ApplicationController
  def top
   @groups = Group.order(created_at: :desc).page(params[:page]).per(6)
    @recent_posts = Post.where(group_id: nil).order(created_at: :desc).page(params[:page]).per(6)
  end
end
