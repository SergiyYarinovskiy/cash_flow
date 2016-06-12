# frozen_string_literal: true
class Exchanger
  attr_reader :general_amount

  def initialize(amount)
    raise 'Amount is empty' unless amount.to_i.positive?
    @general_amount = amount.to_i
  end

  def exchange
    raise "#{general_amount} is too big" if general_amount > Bank.total

    @coins = Bank.instance.dup
    return result if loop_through_coins(@coins.each).zero?

    @coins = Bank.instance.dup
    return result if loop_through_coins(@coins.reverse_each).zero?

    raise "Can't split #{general_amount}"
  end

  private

  def loop_through_coins(coins_enumerator)
    amount = general_amount

    coins_enumerator.each do |coin_pair|
      amount = calculate_coin(amount, coin_pair)
    end

    amount
  end

  def calculate_coin(amount, coin_pair)
    while amount >= coin_pair.first && coin_pair.last > 0
      amount -= coin_pair.first
      coin_pair << coin_pair.pop - 1
    end
    @coins[coin_pair.first] = coin_pair.last
    amount
  end

  def result
    diff = {}
    HashDiff.diff(Bank.instance, @coins).map do |array_diff|
      diff[array_diff[1]] = array_diff[2] - array_diff[3]
    end

    Bank.save @coins
    diff
  end
end
