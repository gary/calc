# frozen_string_literal: true

module Calc
  class Calculator
    attr_reader :stack
    private :stack

    def initialize
      @stack = []
    end

    # @api
    # @param input [Numeric] number to perform an operation on
    # @return [Numeric] the input
    def process(input:)
      result = stack.push(input).first

      result
    end
  end
end
