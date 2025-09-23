# frozen_string_literal: true

require 'hexlet_code'
require 'spec_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

RSpec.describe HexletCode do
  let(:user) { User.new name: 'rob', job: 'hexlet', gender: 'm' }

  describe 'basic form generation' do
    it 'empty form' do
      expect(HexletCode.form_for(user)).to eq '<form action="#" method="post"></form>'
    end

    it 'form with class' do
      result = HexletCode.form_for user, class: 'hexlet-form'
      expect(result).to eq '<form action="#" method="post" class="hexlet-form"></form>'
    end

    it 'form with url and class' do
      result = HexletCode.form_for user, url: '/profile', class: 'hexlet-form'
      expect(result).to eq '<form action="/profile" method="post" class="hexlet-form"></form>'
    end
  end

  describe 'input fields' do
    it 'name and job inputs' do
      result = HexletCode.form_for user do |f|
        f.input :name
        f.input :job, as: :text
      end
      expected = '<form action="#" method="post"><label for="name">Name</label>' \
                 '<input name="name" type="text" value="rob">' \
                 '<label for="job">Job</label><textarea name="job" cols="20" rows="40">hexlet</textarea></form>'
      expect(result).to eq expected
    end

    it 'input with custom attributes' do
      result = HexletCode.form_for user, url: '#' do |f|
        f.input :name, class: 'user-input'
      end
      expected = '<form action="#" method="post"><label for="name">Name</label>' \
                 '<input name="name" type="text" value="rob" class="user-input"></form>'
      expect(result).to eq expected
    end
  end

  describe 'textarea fields' do
    it 'textarea with custom size' do
      result = HexletCode.form_for user do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
      expected = '<form action="#" method="post"><label for="job">Job</label>' \
                 '<textarea name="job" cols="50" rows="50">hexlet</textarea></form>'
      expect(result).to eq expected
    end
  end

  describe 'error handling' do
    it 'raises error for undefined field' do
      expect do
        HexletCode.form_for user do |f|
          f.input :age
        end
      end.to raise_error(NoMethodError)
    end
  end

  describe 'submit button' do
    it 'default submit' do
      result = HexletCode.form_for user, &:submit
      expect(result).to eq '<form action="#" method="post"><input type="submit" value="Save"></form>'
    end

    it 'submit with custom text' do
      result = HexletCode.form_for user do |f|
        f.submit 'Wow'
      end
      expect(result).to eq '<form action="#" method="post"><input type="submit" value="Wow"></form>'
    end
  end

  describe 'labels' do
    it 'label with input' do
      result = HexletCode.form_for user do |f|
        f.input :job
      end
      expected = '<form action="#" method="post"><label for="job">Job</label>' \
                 '<input name="job" type="text" value="hexlet"></form>'
      expect(result).to eq expected
    end
  end
end
