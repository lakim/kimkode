class HomeController < ApplicationController

  def index
    @posts = Post.all.last(20)
    # TODO: add caching
    # Cache key: last_updated_file_date
  end
end