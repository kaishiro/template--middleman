##
# config.rb
#
# @author   Matthew White <matt@substructu.re>
# @date     2014-08-25
#
# This is the base configuration file for Middleman.
##


##
# Requires
##

# Require any local environment variables that exist
require './env' if File.exists?('env.rb')


##
# Core Configuration
##

# Set Environment [:development, :build]
config[:environment] = :development

# Set Directories
config[:source] = 'source'
config[:build_dir] = '../build/www'
config[:css_dir] = 'stylesheets'
config[:js_dir] = 'javascripts'
config[:images_dir] = 'images'
config[:fonts_dir] = 'fonts'
config[:layouts_dir] = 'layouts'
config[:partials_dir] = 'partials'
config[:helpers_dir] = 'helpers'

# Set Default Layout
config[:layout] = 'layout.erb'

# Set Default Index
config[:index_file] = 'index.html'

# Set Markdown Engine
config[:markdown_engine] = :kramdown

# Set Miscellaneous Options
config[:relative_links] = true
config[:strip_index_file] = true
config[:trailing_slash] = true


##
# Environment Configuration
##

# Development Environment
configure :development do
end

# Build Environment
configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end


##
# Extensions
##

activate :directory_indexes
activate :automatic_image_sizes
activate :livereload
activate :cache_buster

# Amazon S3 Sync
activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = ENV['S3_BUCKET']
  s3_sync.region                     = ENV['S3_REGION']
  s3_sync.aws_access_key_id          = ENV['S3_KEY']
  s3_sync.aws_secret_access_key      = ENV['S3_SECRET']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default. 
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false 
end
