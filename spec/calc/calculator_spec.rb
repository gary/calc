# frozen_string_literal: true

require 'spec_helper'

require 'calc/calculator'

RSpec.describe Calc::Calculator do
  subject(:calculator) { described_class.new }

  describe '#process' do
    context 'when the input is numeric' do
      it 'returns it' do
        expect(calculator.process(input: 1)).to eq 1
      end
    end
  end
end
