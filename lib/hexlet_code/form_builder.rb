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

    def submit(button_value = 'Save', **attrs)
      final_attrs = { type: 'submit', value: button_value }
      final_attrs.merge!(attrs)

      @fields << HexletCode::Tag.build('input', **final_attrs)
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

      build_lable(name) + HexletCode::Tag.build('input', **final_attrs)
    end

    def build_lable(name)
      final_attrs = { for: name }

      HexletCode::Tag.build('label', **final_attrs) { name.capitalize.to_s }
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

# User = Struct.new(:name, :job, keyword_init: true)
# user = User.new job: 'hexlet'

# HexletCode.form_for user do |f|
#   f.input :name
#   f.input :job
#   f.submit
#   f.submit 'Wow'
# end

# <form action="#" method="post">
#   <label for="name">Name</label>
#   <input name="name" type="text" value="">
#   <label for="job">Job</label>
#   <input name="job" type="text" value="hexlet">
#   <input type="submit" value="Save">
#   <input type="submit" value="Wow">
# </form>
