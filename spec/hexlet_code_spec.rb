# frozen_string_literal: true

require 'hexlet_code'
require 'spec_helper'

User = Struct.new(:name, :job, keyword_init: true)

RSpec.describe HexletCode do
  describe '.form_for' do
    let(:user) { User.new name: 'rob' }

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
end
