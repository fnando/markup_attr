module MarkupAttr
  class Markup
    attr_accessor :markup

    class << self
      attr_accessor :markdown_processor
    end

    def initialize(format, text)
      case format
      when :markdown
        @markup = (self.class.markdown_processor || default_markdown_processor).new(text)
      when :textile
        @markup = RedCloth.new(text)
      else
        raise ArgumentError, "expected format to be :textile or :markdown; received #{format.inspect}"
      end
    end

    def default_markdown_processor
      Redcarpet
    end

    def to_html
      @markup.to_html
    end
  end
end
