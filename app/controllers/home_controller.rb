class HomeController < ApplicationController
  def index
    @exchange = Exchange.find_by_name('cex.io')
    @series = []

    @exchange.currencies.each do |curr|
      changes = curr.balance_changes.recent.select(:created_at, :new_balance)
      points = changes.map do |bc|
        [ bc.created_at.to_i * 1000, bc.new_balance.to_f / 10 ** 8 ]
      end
      @series << {
        name: curr.full_name,
        data: points
      }
    end

  end
end
