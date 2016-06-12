# frozen_string_literal: true
class Bank
  class << self
    def instance
      @bank ||= empty_bank
    end

    def save(value)
      @bank = empty_bank.update value
    end

    def update(values)
      @bank.merge!(values) { |_, value1, value2| value1 + value2 }
    end

    def total
      sum = 0
      instance.to_a.each { |coins_pair| sum += coins_pair.first * coins_pair.last }
      sum
    end

    private

    def empty_bank
      { 1 => 0, 2 => 0, 5 => 0, 10 => 0, 25 => 0, 50 => 0 }
    end
  end
end
