###
# Settings
###
set :site_title, "OpenShift Discovery Center"
set :site_url, 'https://discover.openshift.com/'
set :openshift_assets, 'https://assets.openshift.net/content'

activate :sitemap
#activate :livereload

set :asciidoc, {
  safe: :safe,
  template_dir: 'source/templates/',
  attributes: %W(showtitle source-highlighter=none env=middleman env-middleman middleman-version=#{Middleman::VERSION})
}

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
helpers do
  def build_breadcrumb(current_page)
    breadcrumbs = {}
    current_path = []
    current_page.path.split(File::SEPARATOR).each do |element|
      current_path.push element
      if element == current_page.path.split(File::SEPARATOR).last
        breadcrumbs["#{current_page.data.title}"] = "/"+current_path.join(File::SEPARATOR)
      else
        breadcrumbs["#{element}"] = "/"+current_path.join(File::SEPARATOR)
      end
    end
    html = ""
    breadcrumbs.each_pair do |key,value|
      html += "<li><a href='#{value}'>#{key.titlecase}</a></li>"
    end
    return html
  end
def build_navtree(root = nil)
    html = ""
    if root == nil 
      root = navtree_yaml = YAML.load_file('data/tree.yml')
    end
    root.each_pair do |folder,contents|
      if contents.is_a?(String)
        extensionlessPath = sitemap.extensionless_path(contents)
      else
        extensionlessPath = sitemap.extensionless_path(folder)
      end
      
        if extensionlessPath.end_with? ".html"
          resource = sitemap.find_resource_by_path(extensionlessPath)
          if resource.nil?
            puts extensionlessPath
          end
          html << "<li><a href='#{resource.url}' class='#{resource == current_page ? 'active' : ''}'>#{resource.data.title}</a></li>"
        else
          if current_page.path.split(File::SEPARATOR).count > 1
            html << "<li><a href='/#{current_page.path.split(File::SEPARATOR).first}/#{folder}' class=''>#{displayname(folder)}</a></li>"
          else
            html << "<li class='parent nav-header'><label class='toggle'><span class='symbol fa fa-angle-right'></span> #{displayname(folder)}</label>"
          end
          html << "<ul>"
          #html << build_navtree(contents)
          if current_page.path.split(File::SEPARATOR).count < 2
            contents.each do |k,v|
              if v.is_a?(String)
                extensionlessPath = sitemap.extensionless_path(v)
              else
                extensionlessPath = sitemap.extensionless_path(k)
              end
              if extensionlessPath.end_with? ".html"
                resource = sitemap.find_resource_by_path(extensionlessPath)
                html << "<li><a href='#{resource.url}' class='#{resource == current_page ? 'active' : ''}'>#{resource.data.title}</a></li>"
              else
                html << "<li><a href='#{folder}/#{k}' class=''>#{displayname(k)}</a></li>"
              end
            end
          end
          html << "</ul>"
          html << "</li>"
        end
    end
    return html
  end

  def nav_index(current_page)
    path = current_page.path.split(File::SEPARATOR)
    if path.count == 1
      return data.tree
    elsif path.count == 2
      return data.tree[path[0]]
    elsif path.count == 3
      return data.tree[path[0]][path[1]]
    end
  end
  
  def displayname(name)
    if data.displaynames[name]
      return data.displaynames[name]
    else
      return name.titlecase
    end
  end
end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

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
