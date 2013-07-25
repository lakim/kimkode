class SitemapController < ApplicationController

  caches_page :show

  def show
    @posts = Post.all
    @last_post = Post.last
    @pages = Page.all
  end

end