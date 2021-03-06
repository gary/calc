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
    EXIT_CHAR = 'q'
    private_constant :EXIT_CHAR

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
      @parser     = Parser.new(whitelist: [*Operations.basic.map(&:sign),
                                           EXIT_CHAR])
    end

    # @api
    # Entry point for execution
    def execute!
      interface.prompt(output: stdout)

      interface.each_line do |items|
        process_input(items)
        interface.prompt(output: stdout)
      end
    ensure
      interface.close
    end

    private

    def process_input(items)
      results = parser.prepare(input: items)

      results.each do |result|
        exit if result == EXIT_CHAR

        stdout.puts calculator.process(input: result)
      rescue Error => e
        stdout.puts e
        next
      end
    end
  end
end
