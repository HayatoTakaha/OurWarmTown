class HomesController < ApplicationController
  def top
    @groups = Group.includes(:posts).all
    @recent_posts = Post.order(created_at: :desc).limit(10)
  end
end