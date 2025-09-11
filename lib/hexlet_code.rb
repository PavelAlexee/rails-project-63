# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  class Tag

    ORDINARY_TAGS = %w[br col img link].freeze

    def build(tag_name, **attributes, &block)
      attrs = build_attributes(attributes)
      tag = "<#{tag_name}#{attrs}>"
      end_tag = "</#{tag_name}>"

      if block_given?
        text = yield
        
        "#{tag}#{text}#{end_tag}"
      else
        ORDINARY_TAGS.include?(tag_name) ? tag : "#{tag}#{end_tag}"
      end
    end

    def build_attributes(attrs)
      attrs.map { |key, value| " #{key}=\"#{value}\"" }.join
    end
  end
end
