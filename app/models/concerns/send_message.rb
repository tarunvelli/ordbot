# frozen_string_literal: true

module SendMessage
  extend ActiveSupport::Concern

  STATE_CHANGE_MAP = {
    'preparing' => lambda do |previous_state, id|
      return unless previous_state == 'received'

      "Order ##{id} has been accepted and is being prepared!"
    end,
    'delivering' => lambda do |previous_state, id|
      return unless Order::PRE_DELIVERY_STATES.include?(previous_state)

      "Order ##{id} is out for delivery!"
    end,
    'delivered' => lambda do |previous_state, id|
      return unless Order::PRE_DELIVERED_STATES.include?(previous_state)

      "Order ##{id} has been delivered, please enjoy your food!"
    end
  }.freeze

  def send_order_update
    previous_state, current_state = saved_change_to_state
    message = STATE_CHANGE_MAP[current_state] && STATE_CHANGE_MAP[current_state][previous_state, id]

    send_message(message)
  end

  def send_confirmation_request
    message = "To confirm your order please reply 'confirm ##{id}'\n\n"
    message += "Your order details are:\n"
    order_items_details.each do |order_item|
      message += "#{order_item[:name]} x #{order_item[:quantity]}\n"
    end
    message += "Cost : #{cost.format}"

    send_message(message)
  end

  def send_message(message)
    return if message.nil? || message == false

    begin
      @restaurant = restaurant
      @client = Twilio::REST::Client.new(
        @restaurant.account_sid, @restaurant.auth_token
      )

      @client.messages.create(
        from: "whatsapp:#{restaurant.phone_number}",
        body: message,
        to: "whatsapp:#{from}"
      )
    rescue StandardError => e
      puts e
    end
  end
end
