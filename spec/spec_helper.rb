require "bundler/setup"
require "rails/all"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

require "sqlite3"
require "redcarpet"
require "RedCloth"
require "nokogiri"
require "markup_attr"

load("schema.rb")

RSpec::Matchers.define :have_tag do |selector, options = {}|
  match do |markup|
    @html = Nokogiri::HTML(markup)
    @nodes = @html.css(selector)
    passed = @nodes.any?

    if options[:text]
      is_regex = options[:text].kind_of?(Regexp)
      checker = is_regex ? -> (node) { node.text.match(options[:text]) } :
                           -> (node) { node.text == options[:text] }

      passed &= @nodes.any?(&checker)
    end

    if options[:count]
      passed &= options[:count] == @nodes.size
    end

    passed
  end

  # match_when_negated do |markup|
  #   require "pry"; binding.pry
  #   !matches?(markup)
  # end

  failure_message do |markup|
    "expect #{markup} to have tag #{selector.inspect} (#{options.inspect})"
  end

  failure_message_when_negated do |markup|
    "expect #{markup} not to have tag #{selector.inspect} (#{options.inspect})"
  end

  description do
    "have tag #{selector.inspect} (#{options.inspect})"
  end
end

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
