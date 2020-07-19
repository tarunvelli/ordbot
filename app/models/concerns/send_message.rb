# frozen_string_literal: true

module SendMessage
  extend ActiveSupport::Concern

  def send_message
    if saved_change_to_state?
      @restaurant = restaurant
      @client = Twilio::REST::Client.new(
        @restaurant.account_sid, @restaurant.auth_token
      )

      state_change = saved_change_to_state
      if state_change[0] == 'received' && state_change[1] == 'preparing'
        message = "Order ##{id} has been accepted and is being prepared!"
      elsif Order::PRE_DELIVERY_STATES.include?(state_change[0]) && state_change[1] == 'delivering'
        message = "Order ##{id} is out for delivery!"
      elsif Order::PRE_DELIVERED_STATES.include?(state_change[0]) && state_change[1] == 'delivered'
        message = "Order ##{id} has been delivered, please enjoy your food!"
      end

      unless message.nil?
        @client.messages.create(
          from: 'whatsapp:+14155238886',
          body: message,
          to: "whatsapp:#{from}"
        )
      end
    end
  end

  def send_confirmation_request
    @restaurant = restaurant
    @client = Twilio::REST::Client.new(
      @restaurant.account_sid, @restaurant.auth_token
    )

    message = "To confirm your order please reply 'confirm ##{id}'\n\n"
    message += "Your order details are:\n"
    items_details.each do |order_item|
      message += "#{order_item[:name]} x #{order_item[:quantity]}\n"
    end
    message += "Cost : ₹ #{cost}"

    @client.messages.create(
      from: 'whatsapp:+14155238886',
      body: message,
      to: "whatsapp:#{from}"
    )
  end
end
