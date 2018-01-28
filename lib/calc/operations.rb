# frozen_string_literal: true

require 'calc/operation'

module Calc
  # @note All operations are restricted to two operands because the
  #   {Calculator} is Postfix
  module Operations
    ADD = Operation.new('+', ->(addend1, addend2) { addend1 + addend2 })
  end
end
