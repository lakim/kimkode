class HomeController < ApplicationController

  def index
    @posts = Post.all.last(20)
  end
end