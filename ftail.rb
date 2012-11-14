#!/usr/bin/env ruby
#
# Simple 'tail -f' example.
# Usage example:
#   tail.rb /var/log/messages

ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require "filewatch/tail"
#require "inotify/fd"

trap('INT') do
  EM.stop
  return 0  
end

def main(args)
  if args.length == 0
    puts "Usage: #{$0} <path> [path2] [...]"
    return 1
  end

  EventMachine.run do
 
    puts "Starting WS server on port 8000"
 
    EventMachine::WebSocket.start(host: '0.0.0.0', port: 1213) do |socket|

      @channel = EM::Channel.new

      socket.onopen do
        @channel.subscribe { |msg| socket.send msg }
        puts 'Client connected!'
      end

      socket.onmessage do |msg|
        puts "Got msg: #{msg}"
      end

      socket.onclose do
        puts "Client closed"
      end

      EventMachine.add_periodic_timer(60) do
        @channel.push("Ping from server at #{Time.now}")
      end

      Thread.new {
        args.each do |path|
          t = FileWatch::Tail.new
          t.tail(path)
          t.subscribe do |path, line|
            msg = "#{path}: #{line}"
            puts msg
            @channel.push(msg)
          end
        end
      }
    end
  end
end # def main

exit(main(ARGV))

