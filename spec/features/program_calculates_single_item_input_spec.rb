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
        2
        2
        +
      TRANSACTION
    end
    let(:expected_result) do
      <<~OUTPUT
        2
        2
        4
      OUTPUT
    end

    it 'calculates the sum' do
      expect(last_command_started.output).to eq expected_result
    end
  end

  context 'when the input contains a mix of whole and decimal numbers' do
    let(:items) do
      <<~TRANSACTION
        5.748
        10.2
        +
        50.37
        +
      TRANSACTION
    end
    let(:expected_result) do
      <<~OUTPUT
        5.748
        10.2
        15.948
        50.37
        66.318
      OUTPUT
    end

    it 'calculates the sum' do
      expect(last_command_started.output).to eq expected_result
    end
  end
end
