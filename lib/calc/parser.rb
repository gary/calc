# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'set'

module Calc
  # Parses input according to 3 rules (in order):
  #
  # * Coerces valid numeric input into {BigDecimal}
  #
  # * Includes input that is on its +whitelist+
  #
  # * Ignores all other input
  class Parser
    attr_reader :whitelist
    private :whitelist

    # @param whitelist [Array<String>] characters to include in parsed output
    def initialize(whitelist:)
      @whitelist = Set[*whitelist]
    end

    # @api
    # @param input [String]
    # @return [Array<BigDecimal>] if +input+ was numeric
    # @return [Array] if +input+ was not in the parser's +whitelist+
    def prepare(input:)
      result = if input.match?(/(?:-)?\d+(?:\.\d+)?/)
                 input.to_d
               elsif whitelist.include?(input)
                 input
               end

      Array(result)
    end
  end
end
