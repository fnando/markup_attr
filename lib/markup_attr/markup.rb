module MarkupAttr
  class Markup
    class << self
      attr_accessor :markdown_processor
      attr_accessor :textile_processor
    end

    self.markdown_processor = Markdown
    self.textile_processor = Textile

    def self.render(format, text)
      engine = public_send("#{format}_processor")
      engine.render(text)
    end
  end
end
