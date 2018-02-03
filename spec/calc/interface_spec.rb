# frozen_string_literal: true

require 'spec_helper'

require 'calc/interface'
require 'stringio'
require 'tmpdir'

RSpec.describe Calc::Interface do
  subject(:interface) { described_class }

  let(:source) { StringIO.new }

  describe '.use' do
    context 'when argv contains a valid file' do
      let(:tmpdir) { Dir.mktmpdir }
      let(:valid_file) { 'calculation.txt' }

      before do
        Dir.chdir(tmpdir)
        File.write(valid_file, 'w') { |f| f.write('2 2 +') }
      end

      it 'returns a new Interface using the file' do
        expect(interface.use(argv: [valid_file], stdin: source))
          .to be_instance_of(interface)
      end
    end

    context 'when argv contains an invalid file' do
      let(:invalid_file) { 'invalid-calculation.txt' }

      it 'raises an exception' do
        expect(interface.use(argv: [invalid_file], stdin: source))
          .to be_kind_of(Calc::ConsoleInterface)
      end
    end
  end
end
