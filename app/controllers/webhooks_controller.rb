class WebhooksController < ActionController::Base
  include WebhookResponder

  skip_before_action :verify_authenticity_token
  # ./ngrok http 3001 to start ngrok

  # post /webhooks
  def receive
    response = receive_message(params)

    render xml: response
  end
end
