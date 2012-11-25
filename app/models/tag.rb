class Tag

  attr_accessor :id, :name, :posts

  # Finders

  def self.all
    # TODO: add proper caching and/or reload in dev
    @all || self._all
  end

  def self._all
    Rails.logger.debug "!!! TAG ALL"
    @all = []
    Post.all.each do |post|
      next if post.tags.blank?
      post.tags.each do |tag_name|
        tag = self.find_by_name(tag_name)
        if tag.nil?
          tag = self.new(tag_name)
          @all << tag
        end
        tag.add_post(post)
      end
    end
    @all.sort! { |a, b| a.name <=> b.name }
  end

  def self.clear_cache
    Rails.logger.debug "!!! TAG CLEAR CACHE"
    puts "!!! TAG CLEAR CACHE"
    @all = nil
  end

  def self.find(id)
    self.all.each do |tag|
      return tag if tag.id == id
    end
    nil
  end

  def self.find_by_name(name)
    self.all.each do |tag|
      return tag if tag.name == name
    end
    nil
  end

  def initialize(name)
    self.id = name.parameterize
    self.name = name
    self.posts = []
  end

  def add_post(post)
    self.posts << post
    self.sort_posts!
  end

  def sort_posts!
    self.posts.sort! { |a, b| a.published_at <=> b.published_at }.reverse
  end

  def post_count
    self.posts.count
  end

end