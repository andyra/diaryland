# Required Gems
# -----------------------------------------------------------------------------

require "bourbon"
require "neat"
Slim::Engine.disable_option_validator!

# Settings
# -----------------------------------------------------------------------------

set :site_title, "Diaryland"
set :site_url, ""
set :site_description, ""
set :site_keywords, ""
set :site_language, "en-us"

# set :relative_links, true
# activate :relative_assets   # Relative URLs
activate :directory_indexes
activate :asset_hash        # Enable cache buster
set :trailing_slash, true

# Markdown engine
set :markdown, :smartypants => true

# Assets
# -----------------------------------------------------------------------------

# Set asset directories
set :css_dir,     "assets/stylesheets"
set :js_dir,      "assets/javascripts"
set :images_dir,  "assets/images"
set :fonts_dir,   "assets/fonts"

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Autoprefixer
activate :autoprefixer do
  config.browsers = ["last 2 versions", "Explorer >= 10"]
  config.cascade  = false
end

# Development config
# -----------------------------------------------------------------------------

configure :development do
  activate :livereload
end

# Build config
# -----------------------------------------------------------------------------

configure :build do
  set :http_prefix, "/diaryland"
  activate :minify_html       # Shrink HTML files
  activate :minify_css        # shrink CSS files
end

# Deploy config
# -----------------------------------------------------------------------------

activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
end

# Blog Settings
# -----------------------------------------------------------------------------

# Time.zone = "UTC"

activate :blog do |blog|
  blog.permalink = "{title}/index.html"
  blog.layout = "blog"
end

page "/feed.xml", layout: false

# Helpers
# -----------------------------------------------------------------------------

helpers do
  # Add active class to nav <%= nav_link_to 'Home', '/index.html' %>
  def nav_link_to(link, url, options = {})
    current_url = current_resource.url
    options[:class] ||= ""
    if current_url == url_for(url) || current_url == url_for(url) + "/"
      options[:class] << " is-active"
    end
    link_to(link, url, options)
  end

  # Turn a string into a slug
  def slugify(string)
    string.downcase.strip.tr(" ", "-").gsub(/[^\w-]/, "")
  end

  # Put this method in your helper file to render inline SVG
  def inline_svg(path)
    File.open("#{path}") do |file|
      raw file.read
    end
  end

  # Shortcut for inserting an SVG image from the master sprite
  def sprite(id, width, height)
    "<svg viewBox='0 0 #{width} #{height}' class='icon #{id}'>" +
      "  <use xlink:href='/assets/images/sprite.min.svg##{id}'></use>" +
      "</svg>"
  end

  def diary_title(article_title)
    title = ""
    unless article_title.nil? || article_title.empty?
      title << article_title + " | "
    end
    title << "Diaryland"
  end

  def figure(image, classes, caption="")
    tag = "<figure class='figure #{classes}'>"
    # tag << "  <img class='figure__image' src='/assets/images/diary/#{image}' alt='#{caption}'>"
    tag << image_tag(image, class: "figure__image")
    unless caption.nil? || caption.empty?
      tag << "  <figcaption class='figure__caption'>#{caption}</figcaption>"
    end
    tag << "</figure>"
  end
end
