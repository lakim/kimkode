class TagsController < ApplicationController

  caches_page :show

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end

end