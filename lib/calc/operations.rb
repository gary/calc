# frozen_string_literal: true

require 'calc/operation'

module Calc
  # @note All operations are restricted to two operands because the
  #   {Calculator} is Postfix
  module Operations
    ADD      = Operation.new('+', ->(addend1, addend2) { addend1 + addend2 })
    MULTIPLY =
      Operation.new('*',
                    ->(multiplicand, multiplier) { multiplicand * multiplier })
    DIVIDE   = Operation.new('/', ->(dividend, divisor) { dividend / divisor })
    SUBTRACT = Operation.new('-',
                             ->(minuend, subtrahend) { minuend - subtrahend })

    module_function

    # @api
    # @return [Array<Operation>] the elementary arithmetic operations
    def basic
      [ADD, DIVIDE, MULTIPLY, SUBTRACT]
    end
  end
end
