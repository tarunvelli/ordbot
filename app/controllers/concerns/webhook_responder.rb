# frozen_string_literal: true

module WebhookResponder
  extend ActiveSupport::Concern

  def receive_message(params)
    case params['Body']
    when 'menu', 'Menu'
      menu_response
    when /add/
      order_response(params)
    else
      default_response
    end
  end

  private

  def default_response
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: 'Default response')
    end

    twiml.to_s
  end

  def menu_response
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Menu:\n1. something\n2. something")
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
