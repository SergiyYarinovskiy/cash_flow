# frozen_string_literal: true
require 'spec_helper'

describe BanksController, type: :controller do
  describe "GET 'index'" do
    let(:empty_bank_coins) do
      { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }
    end

    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

    context 'JSON view' do
      it 'renders coins as json' do
        allow(Bank).to receive(:instance).and_return empty_bank_coins
        get :index
        expect(response.body).to eql(empty_bank_coins.to_json)
      end
    end
  end

  describe "GET 'create'" do
    it 'redirects to the root path' do
      allow(Bank).to receive(:save).and_return true
      get :create
      expect(response).to redirect_to root_path
    end
  end

  describe "GET 'update'" do
    it 'redirects to the root path' do
      allow(Bank).to receive(:update).and_return true
      get :update
      expect(response).to redirect_to root_path
    end
  end

  describe "GET 'exchange'" do
    let(:one_to_one_coins) { { 1 => 1 } }

    it 'raises error because of empty amount' do
      expect { get :exchange }.to raise_error(RuntimeError, 'Amount is empty')
    end

    it 'raises error because of big amount' do
      allow(Bank).to receive(:total).and_return 1
      expect { get :exchange, amount: 2 }
        .to raise_error(RuntimeError, '2 is too big')
    end

    it "raises error because can't split" do
      allow(Bank).to receive(:instance).and_return 2 => 1
      allow(Bank).to receive(:total).and_return 2
      expect { get :exchange, amount: 1 }
        .to raise_error(RuntimeError, "Can't split 1")
    end

    context 'JSON view' do
      it 'renders coins for exchange as json' do
        allow_any_instance_of(Exchanger)
          .to receive(:exchange).and_return one_to_one_coins
        get :exchange, amount: 1
        expect(response.body).to eql(one_to_one_coins.to_json)
      end
    end
  end
end
