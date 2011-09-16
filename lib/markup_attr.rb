require "singleton"
require "active_record"
require "action_view"

module MarkupAttr
  autoload :Markup, "markup_attr/markup"
  autoload :Sanitize, "markup_attr/sanitize"
  autoload :Version, "markup_attr/version"

  require "markup_attr/active_record"
end

ActiveRecord::Base.send(:include, MarkupAttr::ActiveRecord)
