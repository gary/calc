# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Calc do
  it 'has a version number' do
    expect(Calc::VERSION).not_to be nil
  end

  it 'does something useful' do
    useful = false
    expect(useful).to eq(true)
  end
end
