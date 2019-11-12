require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/moneris/engine'
require 'workarea/moneris/version'

require 'active_merchant/billing/bogus_moneris_gateway'

module Workarea
  module Moneris
    # Credentials for Moneris from Rails secrets.
    #
    # @return [Hash]
    def self.credentials
      return {} unless Rails.application.secrets.moneris.present?
      Rails.application.secrets.moneris.symbolize_keys
    end

    # Conditionally use the real gateway when secrets are present.
    # Otherwise, use the bogus gateway.
    #
    # @return [ActiveMerchant::Billing::Gateway]
    def self.gateway
      Workarea.config.gateways.credit_card
    end

    def self.gateway=(gateway)
      Workarea.config.gateways.credit_card = gateway
    end

    def self.auto_initialize_gateway
      if credentials.present?
        if ENV['HTTP_PROXY'].present?
          uri = URI.parse(ENV['HTTP_PROXY'])
          ActiveMerchant::Billing::MonerisGateway.proxy_address = uri.host
          ActiveMerchant::Billing::MonerisGateway.proxy_port = uri.port
        end

        self.gateway = ActiveMerchant::Billing::MonerisGateway.new credentials
      else
        self.gateway = ActiveMerchant::Billing::BogusMonerisGateway.new
      end
    end
  end
end
