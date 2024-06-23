class SearchController < ApplicationController
  def index
    @query = params[:query]
    @posts = Post.where("title LIKE ? OR content LIKE ?", "%#{@query}%", "%#{@query}%")
    @users = User.where("name LIKE ?", "%#{@query}%")
  end
end
