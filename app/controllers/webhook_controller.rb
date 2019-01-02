class WebhookController < ApplicationController
  def receive
    unless verified_webhook_request?
      render plain: 'x', status: 400
      return
    end

    LineHandler.new(request.body.read).handle
    render plain: 'ok', status: 200
  end

  private

  def client
    @client ||= LineClientFactory.create
  end

  def verified_webhook_request?
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    client.validate_signature(body, signature)
  end
end