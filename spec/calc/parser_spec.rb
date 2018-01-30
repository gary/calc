# frozen_string_literal: true

require 'spec_helper'

require 'calc/parser'
require 'rspec/collection_matchers'

RSpec.describe Calc::Parser do
  subject(:parser) { described_class.new(whitelist: '+') }

  describe '#prepare' do
    let(:result) { parser.prepare(input: item) }

    context 'when the input is a single number' do
      let(:item) { '5.5' }

      it 'returns its coerced value in an Array' do
        expect(result).to have_exactly(1).item
      end
    end

    context 'when the input is included in the whitelist' do
      let(:item) { '+' }

      it 'returns it in an Array' do
        expect(result).to match_array([item])
      end
    end

    context 'when the input is not in the whitelist' do
      let(:item) { 'foo' }

      it 'returns an empty Array' do
        expect(result).to match_array([])
      end
    end

    context 'when the input is a single, positive integer' do
      let(:item) { '42' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(42)
      end
    end

    context 'when the input is a single, negative integer' do
      let(:item) { '-42' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(-42)
      end
    end

    context 'when the input is a single, positive decimal' do
      let(:item) { '3.14159' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(3.14159)
      end
    end

    context 'when the input is a single, negative decimal' do
      let(:item) { '-3.14159' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(-3.14159)
      end
    end
  end
end
