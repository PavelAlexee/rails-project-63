# frozen_string_literal: true

module HexletCode
  class FormBuilder
    def initialize(user)
      @user = user
      @fields = []
    end

    def input(name, **attrs)
      raise NoMethodError, "undefined method `#{name}' for #{@user.inspect}" unless @user.respond_to?(name)

      value = @user.public_send(name)
      attrs[:value] = value

      @fields << if attrs[:as] == :text
                   build_textarea(name, **attrs)
                 else
                   build_input(name, **attrs)
                 end
    end

    def to_s
      @fields.join
    end

    private

    def build_input(name, **attrs)
      type = attrs.delete(:type) || 'text'
      value = attrs.delete(:value)

      final_attrs = { name: name, type: type, value: value }
      final_attrs.merge!(attrs)

      HexletCode::Tag.build('input', **final_attrs)
    end

    def build_textarea(name, **attrs)
      attrs.delete(:as)
      rows = attrs.delete(:rows) || 40
      cols = attrs.delete(:cols) || 20
      value = attrs.delete(:value)

      attrs = { name: name, cols: cols, rows: rows }.merge(attrs)
      HexletCode::Tag.build('textarea', **attrs) { value }
    end
  end
end
