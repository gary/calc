# frozen_string_literal: true

require 'spec_helper'
require 'support/aruba'

RSpec.describe 'Calc calculates single item input', type: :aruba do
  before do
    run('calc')
    stop_all_commands
  end

  it 'fails' do
    expect(sanitize_text(last_command_started.output)).to eq 'fail'
  end
end
