# frozen_string_literal: true
class BanksController < ApplicationController
  include ParamsConverter

  # Status
  def index
    render json: Bank.instance
  end

  # Set amount of money. Rewrite existing values
  def create
    Bank.save coins_params
    redirect_to root_path
  end

  # Add money to the bank
  def update
    Bank.update coins_params
    redirect_to root_path
  end

  # Exchange money
  def exchange
    render json: Exchanger.new(params[:amount]).exchange
  end

  private

  def coins_params
    convert_to_i params.permit('1', '2', '5', '10', '25', '50')
  end
end
