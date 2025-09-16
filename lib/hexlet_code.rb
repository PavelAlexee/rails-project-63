# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :VERSION, 'hexlet_code/version'

  class Error < StandardError; end

  def self.form_for(_user, **attributes)
    form_attrs = { action: '#', method: 'post' }

    form_attrs[:action] = attributes.delete(:url) if attributes.key?(:url)

    form_attrs.merge!(attributes)
    Tag.build('form', **form_attrs)
  end
end
