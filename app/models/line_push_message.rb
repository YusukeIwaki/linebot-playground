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
    @client ||= LineClientFactory.create
  end
end