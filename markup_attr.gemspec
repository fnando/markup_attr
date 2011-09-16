# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "markup_attr/version"

Gem::Specification.new do |s|
  s.name        = "markup_attr"
  s.version     = MarkupAttr::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/markup_attr"
  s.summary     = "This ActiveRecord plugin saves formatted content (Markdown, Textile, HTML) after normalizing it."
  s.description = s.summary

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", "~> 3.0"
  s.add_dependency "actionpack", "~> 3.0"

  s.add_development_dependency "nokogiri", "~> 1.5"
  s.add_development_dependency "redcarpet"    , "~> 1.17"
  s.add_development_dependency "RedCloth"     , "~> 4.2"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"        , "~> 2.6"
  s.add_development_dependency "sqlite3"      , "~> 1.3"
  s.add_development_dependency "swiss_knife"  , "~> 1.0"
  s.add_development_dependency "ruby-debug19"
end
