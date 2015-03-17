module MarkupAttr
  class Markdown
    class << self
      attr_accessor :engine
    end

    self.engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML)

    def self.render(text)
      engine.render(text)
    end
  end
end
