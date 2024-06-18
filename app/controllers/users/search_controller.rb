module Users
  class SearchController < ApplicationController
    def index
      @results = Post.where('title LIKE ?', "%#{params[:query]}%").or(Post.where('content LIKE ?', "%#{params[:query]}%"))
    end
  end
end
