class LineHandler
  def initialize(body)
    @body = body
  end

  def handle
    client.parse_events_from(@body).each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text # MessageType::Textの場合の処理
          text = event.message['text']
          message = {
            type: 'text',
            text: "> #{text}\n\nどーも"
          }
          # 返事を送信
          client.reply_message(event['replyToken'], message)
        end
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end