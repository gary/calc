# frozen_string_literal: true

require 'spec_helper'

# @note Leveraging +bigdecimal/utils+ from Parser in its tests because
#       manually instantiating +BigDecimal+ is cumbersome
# @example Instantiate a +BigDecimal+ using bigdecimal/utils
#   '3.5'.to_d #=> 0.35e1
require 'calc/parser'
require 'rspec/collection_matchers'

RSpec.describe Calc::Parser do
  subject(:parser) { described_class.new(whitelist: ['+', '-']) }

  describe '#prepare' do
    let(:result) { parser.prepare(input: items) }

    context 'when the input is a single number' do
      let(:items) { '5.5' }

      it 'returns its coerced value in an Array' do
        expect(result).to have_exactly(1).items
      end
    end

    context 'when the input is included in the whitelist' do
      let(:items) { '+' }

      it 'returns it in an Array' do
        expect(result).to match_array([items])
      end
    end

    context 'when the input is not in the whitelist' do
      let(:items) { 'foo' }

      it 'returns an empty Array' do
        expect(result).to match_array([])
      end
    end

    context 'when the input contains numbers and whitelisted items' do
      let(:items) { '3.5 5 + 8 -' }

      it 'returns an Array containing BigDecimals and the whitelisted items' do
        expect(result)
          .to contain_exactly('3.5'.to_d, '5'.to_d, '+', '8'.to_d, '-')
      end
    end

    context 'when the input contains valid, invalid, and whitelisted items' do
      let(:items) { '3.75 a 6 - 10 25 + z' }

      it 'returns an Array containing BigDecimals and the whitelisted items' do
        expect(result)
          .to contain_exactly('3.75'.to_d, '6'.to_d, '-',
                              '10'.to_d, '25'.to_d, '+')
      end
    end

    context 'when the input is a single, positive integer' do
      let(:items) { '42' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(42)
      end
    end

    context 'when the input is a single, negative integer' do
      let(:items) { '-42' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(-42)
      end
    end

    context 'when the input is a single, positive decimal' do
      let(:items) { '3.14159' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(3.14159)
      end
    end

    context 'when the input is a single, negative decimal' do
      let(:items) { '-3.14159' }

      it 'coerces it into a BigDecimal' do
        expect(result).to match_array([kind_of(BigDecimal)])
          .and contain_exactly(-3.14159)
      end
    end
  end
end
