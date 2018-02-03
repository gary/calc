# frozen_string_literal: true

require 'calc/calculator'
require 'calc/error'
require 'calc/interface'
require 'calc/operations'
require 'calc/parser'
require 'calc/result_formatter'

module Calc
  # Collaborates with all of the necessary objects in the system to
  # facilitate calculation.
  class Main
    attr_reader :argv, :calculator, :interface, :parser, :stdin, :stdout
    private :argv, :calculator, :interface, :parser, :stdin, :stdout

    # @param argv [Array] arguments passed to program
    # @param stdin [IO] the standard input
    # @param stdout [IO] the standard output
    def initialize(argv, stdin: STDIN, stdout: STDOUT)
      @argv       = argv
      @stdin      = stdin
      @stdout     = stdout

      @calculator = Calculator.new(operations: Operations.basic)
                              .extend(ResultFormatter)
      @interface  = Interface.use(argv: argv, stdin: stdin)
      @parser     = Parser.new(whitelist: Operations.basic.map(&:sign))
    end

    # @api
    # Entry point for execution
    def execute!
      process_input(interface)
    ensure
      interface.close
    end

    private

    def process_input(interface)
      interface.prompt(output: stdout)

      interface.each_line do |items|
        results = parser.prepare(input: items)

        results.each do |result|
          stdout.puts calculator.process(input: result)
        end
        interface.prompt(output: stdout)
      end
    end
  end
end
