module MarkupAttr
  module ActiveRecord
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods

        class << self
          attr_accessor :markup_attr_options
        end
      end
    end

    module ClassMethods
      def markup_attr(attribute, options = {})
        self.markup_attr_options ||= {}
        self.markup_attr_options[attribute] = options.reverse_merge(
          :sanitize   => true,
          :attributes => %w[title id href alt href],
          :tags       => %w[p ul ol li strong em a code pre]
        )

        before_save :convert_content_for_markup_attributes
      end
    end

    module InstanceMethods
      private
      def convert_content_for_markup_attributes
        self.class.markup_attr_options.each do |attr_name, options|
          sanitize_markup(attr_name, options.dup)
        end
      end

      def sanitize_markup(attr_name, options)
        return unless __send__("#{attr_name}_changed?") || __send__("formatted_#{attr_name}").blank?

        format = options.delete(:format)

        text = __send__(attr_name).to_s
        text = MarkupAttr::Markup.render(format, text) unless format == :html
        text = MarkupAttr::Sanitize.html(text, options) if options[:sanitize]
        write_attribute("formatted_#{attr_name}", text)
      end
    end
  end
end
