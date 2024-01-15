require 'telegram/bot'
require_relative 'commands.rb'
require_relative 'prhases.rb'
require_relative 'logging.rb'
require_relative 'config.rb'
require_relative 'functions.rb'

Telegram::Bot::Client.run($token) do |bot|
    bot.listen do |message|
      case message.text
      when $cmd_start
        puts "#{$accept} #{$cmd_start}"
        bot.api.send_message(chat_id: message.chat.id, text: $start_text)
      when $cmd_help
        puts "#{$accept} #{$cmd_help}"
        bot.api.send_message(chat_id: message.chat.id, text: $help_text)
      when $cmd_joke
        puts "#{$accept} #{$cmd_joke}"
        joke = get_random_joke # Функция для получения случайной шутки
        bot.api.send_message(chat_id: message.chat.id, text: joke)
        puts "#{$send} #{joke}"
      when $cmd_game
        puts "#{$accept} #{$cmd_game}"
        bot.api.send_message(chat_id: message.chat.id, text: $game_text)
      when $cmd_stop
        puts "#{$accept} #{$cmd_stop}"
        bot.api.send_message(chat_id: message.chat.id, text: $stop_text)
      when '!!!'
        abort 'ПИТАНИЕ НА НОЛЬ'
      else
        if message.text.to_i.to_s == message.text && message.text.to_i.between?(1, 10)
          guess = message.text.to_i
          number = rand(1..10)
          puts "Загадал: #{number}"
          puts "User: #{guess}"
          if guess == number
            bot.api.send_message(chat_id: message.chat.id, text: $win_text)
          else
            bot.api.send_message(chat_id: message.chat.id, text: "#{$lose_text} #{number}")
          end
        else
          $dont_know = message.text.to_s
          bot.api.send_message(chat_id: message.chat.id, text: "#{$none_text} #{$dont_know}")
          puts "Не знаю ответа на: #{$dont_know}"
        end
      end
    end
end
  