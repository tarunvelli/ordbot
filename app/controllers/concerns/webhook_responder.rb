# frozen_string_literal: true

module WebhookResponder
  extend ActiveSupport::Concern

  def receive_message(params)
    case params['Body']
    when /confirm|Confirm/
      confirm_response(params)
    when /add/
      order_response(params)
    else
      default_response
    end
  end

  private

  def confirm_response(params)
    from = params['From'].gsub('whatsapp:', '')
    message = params['Body']

    id = /(\d+)/.match(message)&.captures&.first
    return if id.nil?

    order = Order.where(id: id, from: from).first
    return unless order

    order.update(state: 'received')
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Order ##{order.id} has been confirmed. Waiting for restaurant to accept order.")
    end

    twiml.to_s
  end

  def default_response
    from = params['From'].gsub('whatsapp:', '')
    url = restaurant_menu_url(@restaurant, u: from.encrypt)
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Please use the following the link to place your order #{url}")
    end

    twiml.to_s
  end

  def order_response(params)
    from = params['From'].gsub('whatsapp:', '')
    note = params['Body'].gsub('add', '')

    order = Order.create(from: from, note: note, state: 'received', restaurant: @restaurant)
    twiml = Twilio::TwiML::MessagingResponse.new do |r|
      r.message(body: "Order ID: #{order.id} received. Waiting for restaurant to accept order.")
    end

    twiml.to_s
  end
end
