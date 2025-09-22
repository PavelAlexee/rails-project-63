# frozen_string_literal: true

require 'hexlet_code'
require 'spec_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

RSpec.describe HexletCode do
  let(:user) { User.new name: 'rob', job: 'hexlet', gender: 'm' }

  describe '.form_for' do
    it 'generates a empty form' do
      generate_tag = HexletCode.form_for user
      expected_form = '<form action="#" method="post"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'generates a form with class' do
      generate_tag = HexletCode.form_for user, class: 'hexlet-form'
      expected_form = '<form action="#" method="post" class="hexlet-form"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'generates a form with class and key url' do
      generate_tag = HexletCode.form_for user, url: '/profile', class: 'hexlet-form'
      expected_form = '<form action="/profile" method="post" class="hexlet-form"></form>'

      expect(generate_tag).to eq expected_form
    end
  end
  describe 'input fields' do
    it 'checks input fields :name and :job' do
      generate_tag = HexletCode.form_for user do |f|
        f.input :name
        f.input :job, as: :text
      end
      expected_form = '<form action="#" method="post"><input name="name" type="text" value="rob">' \
                      '<textarea name="job" cols="20" rows="40">hexlet</textarea></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'checks input fields with additional attributes' do
      generate_tag = HexletCode.form_for user, url: '#' do |f|
        f.input :name, class: 'user-input'
        f.input :job
      end
      expected_form = '<form action="#" method="post"><input name="name" type="text" value="rob" class="user-input">' \
                      '<input name="job" type="text" value="hexlet"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'checks textarea with custom attributes' do
      generate_tag = HexletCode.form_for user do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
      expected_form = '<form action="#" method="post"><textarea name="job" cols="50" rows="50">hexlet</textarea></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'raises error for undefined field' do
      expect do
        HexletCode.form_for user do |f|
          f.input :age
        end
      end.to raise_error(NoMethodError)
    end
  end
end
