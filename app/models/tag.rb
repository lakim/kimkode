class Tag

  attr_accessor :id, :name, :posts

  # Finders

  def self.all
    @all || begin
      @all = []
      Post.all.each do |post|
        post.tags.each do |tag|
          unique_tag = find(tag) || tag
          unique_tag.add_post(post)
          @all << tag if (unique_tag == tag)
        end
      end
      @all.sort_by! { |tag| tag.name.downcase }
    end
  end

  def self.clear_cache
    @all = nil
  end

  def self.find(tag_or_id)
    id = tag_or_id.is_a?(Tag) ? tag_or_id.id : tag_or_id
    all.find { |tag| tag.id == id }
  end

  def self.find_by_name(name)
    all.find { |tag| tag.name == name }
  end

  # Init

  def initialize(name)
    self.id = name.parameterize
    self.name = name
    self.posts = []
  end

  # Accessors

  def path
    "/tags/#{self.id}"
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