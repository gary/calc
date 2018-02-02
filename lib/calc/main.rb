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
    attr_reader :argv, :calculator, :parser, :stdin, :stdout
    private :argv, :calculator, :parser, :stdin, :stdout

    # @param argv [Array] arguments passed to program
    # @param stdin [IO] the standard input
    # @param stdout [IO] the standard output
    def initialize(argv, stdin: STDIN, stdout: STDOUT)
      @argv       = argv
      @stdin      = stdin
      @stdout     = stdout

      @calculator = Calculator.new(operations: Operations.basic)
                              .extend(ResultFormatter)
      @parser     = Parser.new(whitelist: Operations.basic.map(&:sign))
    end

    # @api
    # Entry point for execution
    def execute!
      calculation = argv.shift

      File.open(calculation, 'r') do |file|
        file.each_line do |items|
          results = parser.prepare(input: items)

          results.each do |result|
            stdout.puts calculator.process(input: result)
          end
        end
      end
    end
  end
end
