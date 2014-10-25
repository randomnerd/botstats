class HomeController < ApplicationController
  def index
    @exchange = Exchange.find_by_name('cex.io')
    @series = @exchange.changes_chart_data
    btc_global = Currency.find_by_name('BTC-GLOBAL')
    @global_mean = (btc_global.try(:balance) || 0).to_f / 10 ** 8
  end
end
