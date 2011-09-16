require "bundler"
Bundler.setup(:default, :development)
Bundler.require

require "sqlite3"
require "redcarpet"
require "RedCloth"
require "nokogiri"
require "swiss_knife/rspec"

require "markup_attr"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

load("schema.rb")

class Post < ActiveRecord::Base
  markup_attr :content,
    :format     => :markdown,
    :tags       => %w[p a em strong ul li],
    :attributes => %w[href]

  markup_attr :excerpt,
    :format => :html
end

class Comment < ActiveRecord::Base
  markup_attr :content,
    :format     => :textile,
    :tags       => %w[p a em strong ul li],
    :attributes => %w[href]
end

class Task < ActiveRecord::Base
  markup_attr :content,
    :format   => :textile,
    :sanitize => false
end
