require 'pry'

require 'lib/hightouch'
activate :hightouch

Encoding.default_external = 'utf-8'

require "redcarpet"
set :markdown_engine, :redcarpet

require 'rygments'
require 'rack/codehighlighter'
page "/blog/*", layout: :articles

use Rack::Codehighlighter,
  :pygments,
  element: 'code',
  markdown: true,
  pattern: /\A:::([-_+\w]+)\s*\n/

configure :build do; end

ready do
  blog.categories.each do |k, v|
    page "/blog/#{k}.html", proxy: "/blog/category.html", ignore: true do
      @category_name = k
    end
  end
end
