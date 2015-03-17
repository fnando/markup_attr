require "singleton"
require "active_record"
require "action_view"

module MarkupAttr
  require "markup_attr/markdown"
  require "markup_attr/textile"
  require "markup_attr/markup"
  require "markup_attr/sanitize"
  require "markup_attr/version"
  require "markup_attr/active_record"
end

ActiveRecord::Base.send(:include, MarkupAttr::ActiveRecord)
