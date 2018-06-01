# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

def sign(url)
  url + "?token=ec7ddd93dc2b56360306dbaad84f84"
end

def sign_d(url)
  url + "?access_token=vpqBqeRX4CGw2OgDdZxv9H26Rw8mIo4Z"
end

helpers do
  def asset_url(path)
    "http://localhost:8888/" + path
  end

  def directus_asset_url(path)
    "http://localhost:8889/" + path
  end
end

activate :data_source do |c|
  c.root = "http://localhost:8888/api/collections"
  c.collection = {
    alias: "cockpit",
    path: sign("listCollections"),
    type: :json,
    items: ->(data) {
      data.map do |ix|
        { alias: ix, path: sign("get/" + ix), type: :json }
      end
    }
  }
end

activate :data_source do |c|
  c.root = "http://localhost:8889/api/1.1/tables"
  c.collection = {
    alias: "directus",
    path: sign_d(""),
    type: :json,
    items: ->(r) {
      r.data.map do |ix|
        puts ix.name
        { alias: ix.name, path: sign_d(ix.name + "/rows"), type: :json}
      end
    }
  }
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
