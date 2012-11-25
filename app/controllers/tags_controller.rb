class TagsController < ApplicationController

  def show
    tag = Tag.find(params[:id])
    @posts = tag.posts
    # TODO: Add caching
    # Cache key: ?
  end

end