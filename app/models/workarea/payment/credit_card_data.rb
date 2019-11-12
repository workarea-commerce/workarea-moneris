module Workarea
  class Payment
    module CreditCardData
      def transaction_args
        {
          order_id: order_id,
          billing_address: billing_address
        }
      end

      def billing_address
        {
          name:       "#{address.first_name} #{address.last_name}",
          company:    address.company,
          address1:   address.street,
          city:       address.city,
          state:      address.region,
          country:    address.country.try(:alpha2),
          zip:        address.postal_code,
          phone:      nil
        }
      end

      def payment_source
        tender.token.presence || tender.to_active_merchant
      end

      # Moneris requires a unique order ID per transaction, even
      # if the transaction was a failure and a new card is used.
      # Appending the time stamp gives some historical context
      # in the moneris payment admin
      def order_id
        @order_id ||= begin
          stamp = DateTime.now.strftime('%Y_%m_%d_%H_%M_%S')
          "#{tender.payment.id}_#{stamp}"
        end
      end
    end
  end
end
