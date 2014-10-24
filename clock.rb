require 'clockwork'
require './config//boot'
require './config/environment'

module Clockwork
  every(1.minute, 'exchange.run_updates') { Exchange.run_updates }
end
