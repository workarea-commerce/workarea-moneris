# frozen_string_literal: true

module ActiveMerchant
  module Billing
    class BogusMonerisGateway < BogusGateway
      def initialize(options = {})
        # noop
      end

      def authorize(money, paysource, _options = {})
        money = amount(money)
        case normalize(paysource)
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, { authorized_amount: money, data_key: '1' }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { authorized_amount: money, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

      def purchase(money, paysource, _options = {})
        money = amount(money)
        case normalize(paysource)
        when /1$/, AUTHORIZATION
          Response.new(true, SUCCESS_MESSAGE, { paid_amount: money, data_key: '1' }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { paid_amount: money, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

      def verify(paysource)
        case normalize(paysource)
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, { data_key: '1' }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { data_key: nil, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

      def store(paysource)
        case normalize(paysource)
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, { data_key: '1' }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { data_key: nil, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end
    end
  end
end
