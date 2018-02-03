# frozen_string_literal: true

require 'spec_helper'
require 'support/aruba'

RSpec.describe 'Calc calculates single item input', type: :aruba do
  before do
    write_file(transaction, items)
    run("calc #{transaction}")
    stop_all_commands
  end

  let(:transaction) { 'transaction.txt' }

  context 'when the input contains only whole numbers' do
    let(:items) do
      <<~TRANSACTION
        2 2 +
        5 *
        4
        -
        12 +
        10 2 /
        +
      TRANSACTION
    end
    let(:expected_result) do
      <<~OUTPUT
        2
        2
        4
        5
        20
        4
        16
        12
        28
        10
        2
        5
        33
      OUTPUT
    end

    it 'calculates the result' do
      expect(last_command_started.output).to eq expected_result
    end
  end

  context 'when the input contains a mix of whole and decimal numbers' do
    let(:items) do
      <<~TRANSACTION
        5.748 10.2 + 50.37 *
        2.8 /
        10.387 +
        5.13
        -
      TRANSACTION
    end
    let(:expected_result) do
      <<~OUTPUT
        5.748
        10.2
        15.948
        50.37
        803.3007
        2.8
        286.8931
        10.387
        297.2801
        5.13
        292.1501
      OUTPUT
    end

    it 'calculates the result' do
      expect(last_command_started.output).to eq expected_result
    end
  end
end
