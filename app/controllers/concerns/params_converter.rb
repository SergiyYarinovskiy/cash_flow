# frozen_string_literal: true
module ParamsConverter
  extend ActiveSupport::Concern

  def convert_to_i(params)
    int_params = {}

    params.each_key do |key|
      int_params[key.to_i] = params[key].to_i
    end

    int_params
  end
end
