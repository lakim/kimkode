class Post < Content

  attr_accessor :published_at, :author, :tags

  # Accessors

  def published_at=(s)
    @published_at = Date.parse(s)
  end

  def tags
    @tags || []
  end

  def tags=(s)
    @tags = s.split(",").map { |name| Tag.new(name.strip) }
  end

  # Overrides

  def sort_value
    published_at
  end

  # Finders

  def self.slug_from_filename(filename)
    super.split("_").last
  end

  # Caching
  
  def self.clear_cache
    Rails.logger.debug "!!! Post#clear_cache"
    @all = nil
  end

end