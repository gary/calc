# frozen_string_literal: true

require 'spec_helper'

require 'calc/calculator'
require 'calc/operations'

RSpec.describe Calc::Calculator do
  # FIXME: #<InstanceDouble(Calc::Operation) (anonymous)>
  #        received unexpected message :perform with (2, 2)
  # instance_double('Calc::Operation',
  #                 sign: '+',
  #                 command: ->(term1, term2) { term1 + term2 })
  let(:add) { Calc::Operations::ADD }

  describe '#process' do
    context 'when the input is numeric' do
      subject(:calculator) { described_class.new(operations: noop) }

      let(:noop) { instance_double('Calc::Operation', sign: 'noop') }

      it 'returns it' do
        expect(calculator.process(input: 1)).to eq 1
      end
    end

    context 'when the input the addition sign and the stack is valid' do
      subject(:calculator) { described_class.new(operations: add) }

      before do
        calculator.process(input: 2)
        calculator.process(input: 2)
      end

      it 'returns the result of the operation' do
        expect(calculator.process(input: '+')).to eq 4
      end
    end

    context 'when the input is a sign but the stack is invalid' do
      subject(:calculator) { described_class.new(operations: add) }

      before { calculator.process(input: 2) }

      it 'raises a TooFewElementsOnStackError' do
        expect { calculator.process(input: '+') }
          .to raise_error(described_class::TooFewElementsOnStackError)
          .with_message('Too few elements on stack')
      end
    end
  end
end
