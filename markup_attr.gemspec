require "./lib/markup_attr/version"

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

  s.add_dependency "activerecord"
  s.add_dependency "actionpack"

  s.add_development_dependency "nokogiri"
  s.add_development_dependency "redcarpet"
  s.add_development_dependency "RedCloth"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "pry-meta"
  s.add_development_dependency "rails"
end
