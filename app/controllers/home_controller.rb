class HomeController < ApplicationController

  caches_page :index

  def index
    @posts = Post.all
  end

end
