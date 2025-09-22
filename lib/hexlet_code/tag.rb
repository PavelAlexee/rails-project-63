# frozen_string_literal: true

module HexletCode
  class Tag
    ORDINARY_TAGS = %w[br col img link input].freeze

    def self.build(tag_name, **attributes, &)
      attrs = build_attributes(attributes)

      if block_given?
        content = yield
        "<#{tag_name}#{attrs}>#{content}</#{tag_name}>"

      else
        ORDINARY_TAGS.include?(tag_name) ? "<#{tag_name}#{attrs}>" : "<#{tag_name}#{attrs}></#{tag_name}>"
      end
    end

    def self.build_attributes(attrs)
      return '' if attrs.empty?

      attrs.map { |key, value| " #{key}=\"#{value}\"" }.join
    end
  end
end
