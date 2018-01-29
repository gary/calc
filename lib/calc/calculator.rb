# frozen_string_literal: true

module Calc
  # Calculates the result of {Operation}s in Reverse Polish (or Postfix)
  # notation. It is composable and can support a wide range of operations.
  class Calculator
    attr_reader :operations, :stack
    private :operations, :stack

    # Raised when an operation is performed with insufficient elements
    # on the stack
    TooFewElementsOnStackError = Class.new(Error)

    # @param operations [Array<Operation>] operations to support
    def initialize(operations:)
      @operations = to_hash(Array(operations))
      @stack = []
    end

    # @api
    # @param input [Numeric, String] number to perform an {Operation} on or
    #   the +sign+ of the {Operation} to perform
    # @raise [TooFewElementsOnStackError] if an operation is attempted
    #   and there are not enough arguments on the stack
    # @return [Numeric] the input was if it is a number
    # @return [Numeric] the result of the {Operation} if the input is a sign
    def process(input:)
      result = if (operation = operations[input])
                 terms = stack.pop(2)

                 operation.calculate(*terms)
               else
                 input
               end

      stack.push(result)

      result
    rescue Error
      raise TooFewElementsOnStackError, 'Too few elements on stack'
    end

    private

    def to_hash(operations)
      operations.each_with_object({}) { |op, mapping| mapping[op.sign] = op }
    end
  end
end
