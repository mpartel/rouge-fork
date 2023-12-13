# -*- coding: utf-8 -*- #
# frozen_string_literal: true

# Derived from Go lexer.

module Rouge
  module Lexers
    class Lol < RegexLexer
      title "Lol"
      desc 'The Language of Learning (compilers course)'
      tag 'lol'
      aliases 'lol'
      filenames '*.lol', '*.loltest'

      mimetypes 'text/x-lol', 'application/x-lol'

      # Characters

      WHITE_SPACE            = /\s+/

      NEWLINE                = /\n/
      UNICODE_CHAR           = /[^\n]/
      UNICODE_LETTER         = /[[:alpha:]]/
      UNICODE_DIGIT          = /[[:digit:]]/

      # Letters and digits

      LETTER                 = /#{UNICODE_LETTER}|_/
      DECIMAL_DIGIT          = /[0-9]/

      # Comments

      COMMENT                = /(?:\/\/|#)(?:(?!#{NEWLINE}).)*/

      # Keywords

      KEYWORD                = /\b(?: while | for | if | then | else | break | continue | var | return | fun | struct | new | delete | readonly )\b/x
      DOTDOTDOT              = /\.\.\.+/

      # Identifiers

      IDENTIFIER             = / (?!#{KEYWORD})
                                 #{LETTER}(?:#{LETTER}|#{UNICODE_DIGIT})* /x

      # Operators and delimiters

      OPERATOR               = / \+ | - | \* | \/ | % | == | \!= | < | <= | > | >= | and | or | not | = | & /x

      SEPARATOR              = / \(     | \)     | \[     | \]     | \{
                               | \}     | \.     | ,      | :      | ;
                               /x

      # Integer literals

      INT_LIT                = /[0-9]#{DECIMAL_DIGIT}*/

      # String literals

      ESCAPED_CHAR           = /\\[abfnrtv\\'"]/
      STRING_LIT             = / "(?: (?!") (?: #{UNICODE_CHAR} | #{ESCAPED_CHAR} ) )*" /x

      # Predeclared identifiers

      PREDECLARED_TYPES      = /\b(?:Int | Bool | Unit)\b/x

      PREDECLARED_CONSTANTS  = /\b(?:true | false)\b/x

      PREDECLARED_FUNCTIONS  = /\b(?:print | printInt | readInt)\b/x

      state :simple_tokens do
        rule(COMMENT,               Comment)
        rule(KEYWORD,               Keyword)
        rule(DOTDOTDOT,             Comment)
        rule(PREDECLARED_TYPES,     Keyword::Type)
        rule(PREDECLARED_FUNCTIONS, Name::Builtin)
        rule(PREDECLARED_CONSTANTS, Name::Constant)
        rule(INT_LIT,               Num)
        rule(OPERATOR,              Operator)
        rule(SEPARATOR,             Punctuation)
        rule(IDENTIFIER,            Name)
        rule(WHITE_SPACE,           Text)
      end

      state :root do
        mixin :simple_tokens
      end
    end
  end
end
