# -*- coding: utf-8 -*- #
# frozen_string_literal: true

describe Rouge::Lexers::Lol do
    let(:subject) { Rouge::Lexers::Lol.new }
  
    describe 'guessing' do
      include Support::Guessing
  
      it 'guesses by filename' do
        assert_guess :filename => 'foo.lol'
      end

      it 'guesses by mimetype' do
        assert_guess :mimetype => 'text/x-lol'
        assert_guess :mimetype => 'application/x-lol'
      end
    end
  end
  