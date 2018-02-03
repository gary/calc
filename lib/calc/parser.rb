# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'set'

module Calc
  # Parses delimited input according to 3 rules (in order):
  #
  # * Coerces valid numeric input into +BigDecimal+
  #
  # * Includes input that is on its +whitelist+
  #
  # * Ignores all other input
  class Parser
    NUMERIC = /\A(?:-)?\d+(?:\.\d+)?\z/
    private_constant :NUMERIC

    attr_reader :whitelist
    private :whitelist

    # @param whitelist [Array<String>] characters to include in parsed output
    def initialize(whitelist:)
      @whitelist = Set[*whitelist]
    end

    # @api
    # @param input [String] single item or space-delimited items
    # @param delimeter [String] character to use the boundary between items
    #   in the +input+
    # @return [Array<BigDecimal>] if +input+ was numeric
    # @return [Array] if +input+ was not in the parser's +whitelist+
    # @return [Array<BigDecimal,String>] if +input+ contained numeric and
    #   whitelisted items
    def prepare(input:, delimeter: ' ')
      input.split(delimeter).each_with_object([]) do |item, output|
        if item.match?(NUMERIC)
          output << item.to_d
        elsif whitelist.include?(item)
          output << item
        end
      end
    end
  end
end
