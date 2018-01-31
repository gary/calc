# frozen_string_literal: true

require 'spec_helper'

require 'bigdecimal'
require 'bigdecimal/util'
require 'calc/result_formatter'

RSpec.describe Calc::ResultFormatter do
  subject(:calculator) do
    Calc::Calculator.new(operations: []).extend(described_class)
  end

  describe '#process' do
    context 'when the number has a fractional part' do
      it 'returns the unrounded floating point representation as a string' do
        expect(calculator.process(input: '3.1415'.to_d)).to eq('3.1415')
      end

      it 'truncates the number to 4 decimal places by default' do
        expect(calculator.process(input: '3.14159168'.to_d)).to eq('3.1415')
      end
    end

    context 'when the number does not have a fractional part' do
      it 'returns the unrounded integer representation as a string' do
        expect(calculator.process(input: '42'.to_d)).to eq('42')
      end
    end
  end
end
