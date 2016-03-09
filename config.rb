###
# Settings
###
set :site_title, "OpenShift Discovery Center"
set :site_url, 'https://discover.openshift.com/'
set :openshift_assets, 'https://assets.openshift.net/content'


activate :navtree do |options|
  options.data_file = 'tree.yml' # The data file where our navtree is stored.
  options.automatic_tree_updates = true # The tree.yml file will be updated automatically when source files are changed.
  options.ignore_files = ['sitemap.xml', 'robots.txt'] # An array of files we want to ignore when building our tree.
  options.ignore_dir = ['assets'] # An array of directories we want to ignore when building our tree.
  options.home_title = 'Home' # The default link title of the home page (located at "/"), if otherwise not detected.
  options.promote_files = ['introduction.html.erb'] # Any files we might want to promote to the front of our navigation
  options.ext_whitelist = [] # If you add extensions (like '.md') to this array, it builds a whitelist of filetypes for inclusion in the navtree.
end

activate :sitemap
activate :breadcrumbs
activate :livereload





###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = false # default: false
  deploy.remote = 'production' # remote name or git url, default: origin
  deploy.branch = 'master' # default: gh-pages
end
