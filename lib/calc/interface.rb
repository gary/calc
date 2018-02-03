# frozen_string_literal: true

module Calc
  # Represents generic behavior for all input interfaces.
  class Interface < SimpleDelegator
    attr_reader :source
    private :source

    # @api
    # @param argv [Array] arguments passed to {Main}
    # @param stdin [IO] the standard input
    # @return [Interface] a generic interface for file input or a
    #   {ConsoleInterface} for an interactive session
    def self.use(argv:, stdin:)
      if (file = argv.shift) && File.exist?(file)
        calculation = File.open(file, 'r')

        new(calculation)
      else
        new(stdin).extend(ConsoleInterface)
      end
    end

    # @param source [IO] where to read input from
    def initialize(source)
      @source = source
    end

    # @api
    # @param output [IO] where to write output to
    # @return [nil]
    def prompt(output:)
      # NOOP
    end

    def __getobj__
      source
    end
  end

  # Represents behavior specific to a console interface.
  module ConsoleInterface
    # @api
    # @param (see Interface#prompt)
    # @return (see Interface#prompt)
    def prompt(output:)
      output.print '> '
    end
  end
end
