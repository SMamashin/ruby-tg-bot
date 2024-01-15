require 'telegram/bot'

token = '#egor_ne_lomay_mne_kompykter!'
stop = 'остановись'
start = '/start'
egor = '/egor'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text # крутой кейс поток
    when start
      name = message.from.first_name
      bot.api.send_message(chat_id: message.chat.id, text: "Здарова надоел, #{name}")
    when egor
        bot.api.send_message(chat_id: message.chat.id, text: 'Егор негр!')
    when stop
        bot.api.send_message(chat_id: message.chat.id, text: 'Торможу, заебал')
        puts 'стоп кран жму?'
        abort 'жму'
    end
  end
end