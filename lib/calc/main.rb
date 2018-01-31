# frozen_string_literal: true

require 'calc/calculator'
require 'calc/error'
require 'calc/operations'
require 'calc/parser'
require 'calc/result_formatter'

module Calc
  # Collaborates with all of the necessary objects in the system to
  # facilitate calculation.
  class Main
    attr_reader :argv, :stdout
    private :argv, :stdout

    # @param argv [Array] arguments passed to program
    # @param stdout [IO] the standard output
    def initialize(argv, stdout: STDOUT)
      @argv   = argv
      @stdout = stdout
    end

    # @api
    # Entry point for execution
    def execute!
      stdout.puts 'fail'
    end
  end
end
