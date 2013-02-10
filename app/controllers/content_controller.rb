class ContentController < ApplicationController

  def show
    content = Content.find(params[:slug])
    raise ActionController::RoutingError if content.nil?
    # Set instance variable using the proper name: @page or @post
    instance_variable_set("@#{content.class.name.underscore}", content)
    @body = process_body(content)
    render "#{content.class.name.underscore.pluralize}/show", :layout => content.layout
    # TODO: add caching
    # Cache key: filename-hash|date
  end

  private
  def process_body(content)
    s = content.body
    content.extensions.each do |ext|
      s = Tilt[ext].new{ s }.render(view_context)
    end
    s.html_safe
  end

end