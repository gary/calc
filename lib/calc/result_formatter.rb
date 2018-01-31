# frozen_string_literal: true

module Calc
  # Formats results from {Calculator#process} for display to the end user.
  module ResultFormatter
    TEN_THOUSANDTHS = 4
    private_constant :TEN_THOUSANDTHS

    # @api
    # @param (see Calculator#process)
    # @param places [Integer] the number of decimal places to truncate
    #   fractional result to
    # @raise (see Calculator#process)
    # @return [String] unrounded, output-ready version of +result+
    def process(input:, places: TEN_THOUSANDTHS)
      result = super(input: input)

      return result.truncate(places).to_s('F') if fractional?(result)
      result.truncate.to_s
    end

    private

    def fractional?(number)
      number.frac.nonzero?
    end
  end
end
