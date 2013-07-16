class Tag

  attr_accessor :id, :name, :posts

  # Finders

  def self.all
    @all ||= begin
      Rails.logger.debug "!!! TAG ALL"
      @all = []
      Post.all.each do |post|
        post.tags.each do |tag|
          unique_tag = self.find(tag) || tag
          unique_tag.add_post(post)
          @all << tag if (unique_tag == tag)
        end
      end
      @all.sort_by! { |tag| tag.name.downcase }
    end
  end

  def self.clear_cache
    Rails.logger.debug "!!! TAG CLEAR CACHE"
    puts "!!! TAG CLEAR CACHE"
    @all = nil
  end

  def self.find(tag_or_id)
    id = tag_or_id.is_a?(Tag) ? tag_or_id.id : tag_or_id
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

  # Init

  def initialize(name)
    self.id = name.parameterize
    self.name = name
    self.posts = []
  end

  # Accessors

  def path
    "tags/#{self.id}"
  end

  # Posts

  def add_post(post)
    self.posts << post
    self.sort_posts!
  end

  def sort_posts!
    self.posts.sort_by! { |post| post.published_at }.reverse
  end

  def post_count
    self.posts.count
  end

end