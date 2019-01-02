require 'line/bot'

class LinePushMessage
  def initialize(user_id)
    @user_id = user_id
  end

  def send(text)
    message = {
      type: 'text',
      text: text
    }
    client.push_message(@user_id, message)
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end