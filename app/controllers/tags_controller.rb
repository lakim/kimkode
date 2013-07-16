class TagsController < ApplicationController

  caches_page :show

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
    # TODO: Add caching
    # Cache key: last_updated_post_file_date
  end

end