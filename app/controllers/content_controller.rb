class ContentController < ApplicationController
  caches_page :show

  def show
    content = Content.find(params[:slug])
    raise ActionController::RoutingError if content.nil?
    # Set instance variable using the proper name: @page or @post
    instance_variable_set("@#{content.class.name.underscore}", content)
    @body = content.html_body
    render "#{content.class.name.underscore.pluralize}/show", :layout => content.layout
  end
end