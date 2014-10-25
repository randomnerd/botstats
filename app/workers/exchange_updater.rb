class ExchangeUpdater
  include Sidekiq::Worker

  def perform(id)
    ex = Exchange.find id
    ex.update_rates
    ex.update_balances
  end
end
