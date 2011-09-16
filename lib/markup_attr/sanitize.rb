module MarkupAttr
  # Use ActionView sanitizer class to strip out HTML
  # in simple contained class.
  #
  class Sanitize
    include Singleton
    extend ActionView::Helpers::SanitizeHelper::ClassMethods
    include ActionView::Helpers::SanitizeHelper

    # Strip all html.
    #
    def self.strip_tags(text)
      instance.strip_tags(text)
    end

    # Strip html from text.
    # You can specify allowed tags and attributes by setting
    # the options <tt>:tags</tt> and <tt>:attributes</tt>.
    #
    #   Sanitize.html(text, {
    #     :tags => %w[a li p ul ol code pre em strong],
    #     :attributes => %w[href]
    #   })
    #
    # Setting <tt>:tags</tt> and <tt>:attributes</tt>
    # to +nil+ will accept everything.
    #
    def self.html(text, options = {})
      instance.sanitize(text, options)
    end
  end
end
