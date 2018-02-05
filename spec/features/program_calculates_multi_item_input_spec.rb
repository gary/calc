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

  context 'when the input contains invalid input' do
    let(:items) do
      <<~TRANSACTION
        3 D34DB33F 4 + 7 *
        10 /
      TRANSACTION
    end
    let(:expected_result) do
      <<~OUTPUT
        3
        4
        7
        7
        49
        10
        4.9
      OUTPUT
    end

    example 'it ignores the invalid input, calculating the result' do
      expect(last_command_started.output).to eq expected_result
    end
  end

  context 'when the input contains invalid operation combinations' do
    let(:items) { '2 + 4 +' }
    let(:expected_result) do
      <<~TRANSACTION
        2
        Too few elements on stack
        4
        6
      TRANSACTION
    end

    example 'it gracefully ignores them' do
      expect(last_command_started).to have_exit_status(0)
    end

    example 'it reports errors and continues execution' do
      expect(last_command_started.output).to eq expected_result
    end
  end

  context 'when the input reaches the end-of-file' do
    let(:items) { '2 2 +' }
    let(:expected_result) do
      <<~TRANSACTION
        2
        2
        4
      TRANSACTION
    end

    example 'exits with a zero status' do
      expect(last_command_started).to have_exit_status(0)
    end
  end

  context "when the input contains a 'q'" do
    let(:items) do
      <<~TRANSACTION
        2 2 + q
        4 +
      TRANSACTION
    end
    let(:expected_result) do
      <<~TRANSACTION
        2
        2
        4
      TRANSACTION
    end

    it 'stops processing input' do
      expect(last_command_started.output).to eq expected_result
    end

    it 'exits with a zero status' do
      expect(last_command_started).to have_exit_status(0)
    end
  end
end
