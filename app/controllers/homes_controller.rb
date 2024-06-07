class HomesController < ApplicationController
  def top
    @groups = Group.all.page(params[:page])
    @posts = Post.all.page(params[:page])
  end

  def about
  end
end