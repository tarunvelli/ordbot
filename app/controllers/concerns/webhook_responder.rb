# frozen_string_literal: true

module WebhookResponder
  extend ActiveSupport::Concern

  def receive_message(params)
    case params['Body']
    when /add/
      order_response(params)
    else
      default_response
    end
  end

  private

  def default_response
    url = restaurant_menu_url(@restaurant)
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Please use the following the link to place your order #{url}")
    end

    twiml.to_s
  end

  def order_response(params)
    from = params['From'].gsub('whatsapp:', '')
    note = params['Body'].gsub('add', '')
    restaurant = Restaurant.find(params['restaurant_id'])

    order = Order.create(from: from, note: note, state: 'received', restaurant: restaurant)
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Order ID: #{order.id} received. Waiting for restaurant to accept order.")
    end

    twiml.to_s
  end
end
