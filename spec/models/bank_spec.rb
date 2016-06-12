# frozen_string_literal: true
require 'spec_helper'

describe Bank do
  before :each do
    described_class.save({})
  end

  let(:empty_coins) do
    { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }
  end

  let(:correct_updated_coins) do
    { 1 => 2, 2 => 2, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }
  end

  it 'initializes bank' do
    expect(described_class.instance).to eql(empty_coins)
  end

  it 'resets and saves coins' do
    described_class.save(1 => 2, 2 => 2)
    expect(described_class.instance).to eql(correct_updated_coins)
  end

  it 'updates coins' do
    described_class.save(1 => 1, 2 => 2)
    described_class.update(1 => 1)
    expect(described_class.instance).to eql(correct_updated_coins)
  end

  it 'returns total coins amount' do
    described_class.save(1 => 1, 2 => 2)
    expect(described_class.total).to eql(5)
  end
end
