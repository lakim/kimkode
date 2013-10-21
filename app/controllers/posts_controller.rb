class PostsController < ApplicationController

  caches_page :index

  def index
    @posts = Post.all
  end

end