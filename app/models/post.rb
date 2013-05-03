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

  # Finders

  def self.all
    @all ||= begin
      Rails.logger.debug "!!! POST ALL"
      all = []
      Dir[File.join(Rails.root, "content", self.name.pluralize.underscore, "[^\*]*")].each do |f|
        all << self.parse(f)
      end
      all.sort { |a, b| a.published_at <=> b.published_at }.reverse
    end
  end

  def self.slug_from_filename(filename)
    super.split("_").last
  end

  # Caching
  def self.clear_cache
    Rails.logger.debug "!!! POST CLEAR CACHE"
    @all = nil
  end

end