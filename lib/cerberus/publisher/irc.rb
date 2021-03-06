require 'rubygems'
require 'IRC'
require 'cerberus/publisher/base'

class Cerberus::Publisher::IRC < Cerberus::Publisher::Base
  def self.publish(state, manager, options)
    irc_options = options[:publisher, :irc]
    raise "There is no channel provided for IRC publisher" unless irc_options[:channel]
    subject,body = Cerberus::Publisher::Base.formatted_message(state, manager, options)
    message = subject + "\n" + '*' * subject.length + "\n" + body


    channel = '#' + irc_options[:channel]
    bot = IRC.new(irc_options[:nick] || 'cerberus', irc_options[:server], irc_options[:port] || 6667)

    silence_stream(STDOUT) {
      IRCEvent.add_callback('endofmotd') { |event| 
        bot.add_channel(channel) 
        message.split("\n").each{|line|
          bot.send_message(channel, line)
        }
        bot.send_quit
      }
      bot.connect
    }
  end
end
