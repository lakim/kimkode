class Content

  attr_accessor :filename, :slug, :extensions, :title, :body

  # Class methods
  
  def self.find(slug)
    filename = self.filename_from_slug(slug)
    return if filename.nil?

    parse(filename)
  end

  def self.parse(filename)
    data, body, extensions = read_file(filename)
    klass = data["published_at"].blank? ? Page : Post
    klass.new(filename, data, body, extensions)
  end

  def self.read_file(filename)
    basename = File.basename(filename)
    published_at = basename.scan(/([^_]+)_/).flatten.first
    extensions = basename.split(".")[1..-1].reverse
    f = File.read(filename)

    if f =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      body = $' # Get the regex $POSTMATCH

      begin
        data = YAML.load($1)
      rescue => e
        puts "YAML Exception reading #{name}: #{e.message}"
      end
    end
    data ||= {}
    data["published_at"] = published_at
    [ data, body, extensions ]
  end

  def self.filename_from_slug(slug)
    Dir[File.join(Rails.root, "content", "**", "*#{slug}.*")].first
  end

  def self.slug_from_filename(filename)
    File.basename(filename).split(".").first
  end

  # Init
  def initialize(filename, data, body, extensions)
    self.filename = filename
    data.each do |k, v|
      self.send("#{k}=", v)
    end
    self.body = body
    self.extensions = extensions
  end

  # Accessors

  def filename=(f)
    @filename = f
    self.slug = self.class.slug_from_filename(f)
  end

  def layout
    @layout ||= "application"
  end

end