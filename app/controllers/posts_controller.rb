class PostsController < ApplicationController

  def index
    @posts = Post.all
    # TODO: Add caching
    # cache key: last_updated_file_date  
  end

end