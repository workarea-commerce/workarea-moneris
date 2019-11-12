require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::Moneris::Engine.root
  Workarea::Teaspoon.apply(config)
end
