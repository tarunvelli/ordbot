class WebhooksController < ActionController::Base
  include WebhookResponder

  before_action :set_validator
  skip_before_action :verify_authenticity_token
  # ./ngrok http 3001 to start ngrok

  # post /webhooks
  def receive
    params.permit!

    return unless @validator.validate(
      request.url,
      request.params.except(:action, :controller, :restaurant_id),
      request.headers['X-Twilio-Signature']
    )

    render xml: receive_message(params)
  end

  private

  def set_validator
    @restaurant = Restaurant.find(params['restaurant_id'])
    @validator = Twilio::Security::RequestValidator.new(@restaurant.auth_token)
  end
end
