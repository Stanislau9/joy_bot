require 'telegram/bot'
require_relative 'want'
# telegram bot token
token = ''


Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    if message.text[0..4]  == 'хочу '
      bot.api.send_message(chat_id: message.chat.id, text: want(message.text))
    end
  end
end