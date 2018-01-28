# frozen_string_literal: true

require 'spec_helper'

require 'calc/operation'

RSpec.describe Calc::Operation do
  subject(:add) do
    operation.new('+', ->(addend1, addend2) { addend1 + addend2 })
  end

  let(:operation) { described_class }

  describe '#initialize' do
    context 'when the command is not a lambda' do
      it 'raises an ArgumentError' do
        expect { operation.new('+', proc { |term1, term2| term1 + term2 }) }
          .to raise_error(ArgumentError)
          .with_message('Command must be a lambda')
      end
    end
  end

  describe '#calculate' do
    context "when the number of terms matches the command's inputs" do
      it 'executes the command' do
        expect(add.calculate(2, 2)).to eq 4
      end
    end

    context "when the number of terms does not match the command's inputs" do
      it 'raises an exception' do
        expect { add.calculate(2, 2, 2) }.to raise_error(ArgumentError)
      end
    end
  end
end
