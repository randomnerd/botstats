class HomeController < ApplicationController
  def index
    @exchange = Exchange.find_by_name('cex.io')
    @series = @exchange.changes_chart_data
  end
end
