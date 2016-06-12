# frozen_string_literal: true
require 'spec_helper'
include ParamsConverter

describe ParamsConverter do
  describe '#convert_to_i' do
    it 'converts params to integers' do
      expect(convert_to_i('1' => '2')).to eql 1 => 2
    end
  end
end
