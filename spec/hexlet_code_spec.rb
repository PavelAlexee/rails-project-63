# frozen_string_literal: true

require 'hexlet_code'
require 'spec_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

RSpec.describe HexletCode do
  let(:user) { User.new name: 'rob', job: 'hexlet', gender: 'm' }

  describe '.form_for basic forms' do
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

  describe '.form_for with different input types' do
    it 'checks input fields :name and :job' do
      generate_tag = HexletCode.form_for user do |f|
        f.input :name
        f.input :job, as: :text
      end
      expected_form = '<form action="#" method="post"><label for="name">Name</label>' \
                      '<input name="name" type="text" value="rob">' \
                      '<label for="job">Job</label><textarea name="job" cols="20" rows="40">hexlet' \
                      '</textarea></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'checks input fields with additional attributes' do
      generate_tag = HexletCode.form_for user, url: '#' do |f|
        f.input :name, class: 'user-input'
      end
      expected_form = '<form action="#" method="post"><label for="name">Name</label>' \
                      '<input name="name" type="text" value="rob" class="user-input"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'checks textarea with custom attributes' do
      generate_tag = HexletCode.form_for user do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
      expected_form = '<form action="#" method="post"><label for="job">Job</label>' \
                      '<textarea name="job" cols="50" rows="50">hexlet</textarea></form>'

      expect(generate_tag).to eq expected_form
    end
  end

  describe '.form_for error handling' do
    it 'raises error for undefined field' do
      expect do
        HexletCode.form_for user do |f|
          f.input :age
        end
      end.to raise_error(NoMethodError)
    end
  end

  describe '.form_for submit functionality' do
    it "checks method 'submit'" do
      generate_tag = HexletCode.form_for user, &:submit

      expected_form = '<form action="#" method="post"><input type="submit" value="Save"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'check labels with input' do
      generate_tag = HexletCode.form_for user do |f|
        f.input :job
      end

      expected_form = '<form action="#" method="post"><label for="job">Job</label>' \
                      '<input name="job" type="text" value="hexlet"></form>'

      expect(generate_tag).to eq expected_form
    end

    it 'check the text for the button' do
      generate_tag = HexletCode.form_for user do |f|
        f.submit 'Wow'
      end

      expected_form = '<form action="#" method="post"><input type="submit" value="Wow"></form>'

      expect(generate_tag).to eq expected_form
    end
  end
end
