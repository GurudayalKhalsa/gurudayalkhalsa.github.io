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
# Blog
###

activate :blog do |blog|
  blog.prefix = "blog"
  blog.layout = "article_layout"
  blog.permalink = "{year}/{month}/{day}/{title}.html"
end

Time.zone = "America/Toronto"

#pretty urls (makes dir instead of .html)
#also used to store assets in same folder
activate :directory_indexes



###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def article_img(src, alt="")
    src = current_page.url + src
    blanksrc = "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
    c1 = "article-image-container"
    c2 = "b-lazy"

    return "<div class='#{c1}'><img class='#{c2}' src='#{blanksrc}' data-src='#{src}' alt='#{alt}' /><noscript><img src='#{src}' alt='#{alt}' /></noscript></div>"

    #e.g. Output
    #<div class="article-image-container"><img class="b-lazy" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="images/pics/_DSF1715.jpg" alt=""><noscript><img src="images/pics/_DSF1715.jpg" /></noscript></div>
  end

  def div(classes, content)
    if content.kind_of?(Array) then content = content.join('') end
    return "<div class='#{classes}'>#{content}</div>"
  end

  def row(content)
    return div("row", content)
  end

  def column(offset="one-half", content)
    if !offset.is_a?(String) then
      content = offset
      offset="one-half"
    end
    return div(offset + " column", content)
  end
end

set :css_dir, 'css'

set :js_dir, 'js'

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
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

# Deploy to GH-Pages
activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.branch = 'master'
  deploy.build_before = true # default: false
  # Optional Settings
  # deploy.remote   = 'custom-remote' # remote name or git url, default: origin
  # deploy.branch   = 'custom-branch' # default: gh-pages
  # deploy.strategy = :submodule      # commit strategy: can be :force_push or :submodule, default: :force_push
  # deploy.commit_message = 'custom-message'      # commit message (can be empty), default: Automated commit at `timestamp` by middleman-deploy `version`
end
