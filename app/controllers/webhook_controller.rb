require 'line/bot'

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
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def verified_webhook_request?
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    client.validate_signature(body, signature)
  end
end