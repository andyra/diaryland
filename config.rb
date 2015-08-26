# Required Gems
# -----------------------------------------------------------------------------

require 'bourbon'
require 'neat'

# Settings
# -----------------------------------------------------------------------------

set :site_title, 'Diary Land'
set :site_url, ''
set :site_description, ''
set :site_keywords, ''
set :site_language, 'en-us'

# Remove .html extension from pages
activate :directory_indexes

# Autoprefixer
activate :autoprefixer do
  config.browsers = ['last 2 versions', 'Explorer >= 10']
  config.cascade  = false
end

# Relative links
# set :relative_links, true

# Assets
# -----------------------------------------------------------------------------

# Set asset directories
set :css_dir,     'assets/stylesheets'
set :js_dir,      'assets/javascripts'
set :images_dir,  'assets/images'
set :fonts_dir,   'assets/fonts'

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

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
    string.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
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
end

# Development config
# -----------------------------------------------------------------------------

configure :development do
  activate :livereload
end

# Build config
# -----------------------------------------------------------------------------

configure :build do
  activate :relative_assets   # Relative URLs
  activate :directory_indexes # Pretty URLs
  activate :asset_hash        # Enable cache buster
  activate :minify_html       # Shrink HTML files
end
