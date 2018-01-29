# frozen_string_literal: true

module Calc
  # A mathematical calculation from zero or more values to an output value.
  # @see https://en.wikipedia.org/wiki/Operation_(mathematics)
  class Operation
    attr_reader :command
    private :command

    # @!attribute [r] sign
    # @return [String] The symbol that signifies the {Operation}
    attr_reader :sign

    # When the operation is calculated with an unexpected number of operands
    OperandMismatchError = Class.new(Error)

    # @param sign [String]
    # @param command [#call] How to calculate the result of the operation
    # @raise [ArgumentError] if the command is not a lambda
    # @example Create operation that adds 2 operands
    #   Operation.new('+', ->(term1, term2) { term1 + term2 })
    def initialize(sign, command)
      raise ArgumentError, 'Command must be a lambda' unless command.lambda?

      @sign      = sign
      @command   = command
    end

    # @api
    # @note signature depends on number of operands specified to the
    #   +command+ at initialization
    # @overload calculate(operand, operand)
    #   Calculates the operation on 0 or more operands
    # @raise [OperandMismatchError] if the calculation is passed the wrong
    #   number of operands
    # @return [Numeric] the result of the operation
    def calculate(*operands)
      command.call(*operands)
    rescue ArgumentError => e
      raise OperandMismatchError, e.message << " to '#{sign}' operation"
    end
  end
end
