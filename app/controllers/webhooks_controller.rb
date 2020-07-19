class WebhooksController < ActionController::Base
  include WebhookResponder

  skip_before_action :verify_authenticity_token
  # ./ngrok http 3001 to start ngrok

  # post /webhooks
  def receive
    params.permit!
    @restaurant = Restaurant.find(params['restaurant_id'])
    validator = Twilio::Security::RequestValidator.new(@restaurant.auth_token)

    url = request.url
    twilio_signature = request.headers['X-Twilio-Signature']
    twilio_params = request.params.except(:action, :controller, :restaurant_id)

    if validator.validate(url, twilio_params, twilio_signature)
      response = receive_message(params)
      render xml: response
    end
  end
end
