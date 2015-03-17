module MarkupAttr
  class Textile
    def self.render(text)
      RedCloth.new(text).to_html
    end
  end
end
