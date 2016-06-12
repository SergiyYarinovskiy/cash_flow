# frozen_string_literal: true
require 'spec_helper'

describe Exchanger do
  describe '#initialize' do
    it 'raises error because of empty amount' do
      expect { described_class.new('-1') }
        .to raise_error(RuntimeError, 'Amount is empty')
    end

    it 'saves general_amount' do
      exchanger = described_class.new('1')
      expect(exchanger.general_amount).to eql 1
    end
  end

  describe '#exchange' do
    before :each do
      allow(Bank).to receive(:instance).and_return(10 => 3, 25 => 1)
    end

    it 'raises error because of empty amount' do
      exchanger = described_class.new(30)
      expect(exchanger.exchange).to eql '10' => 3
    end

    it 'saves general_amount' do
      exchanger = described_class.new(35)
      expect(exchanger.exchange).to eql('10' => 1, '25' => 1)
    end

    it 'raises error because of empty amount' do
      exchanger = described_class.new(300)
      expect { exchanger.exchange }.to raise_error(RuntimeError, '300 is too big')
    end

    it 'saves general_amount' do
      exchanger = described_class.new(5)
      expect { exchanger.exchange }.to raise_error(RuntimeError, "Can't split 5")
    end
  end
end
