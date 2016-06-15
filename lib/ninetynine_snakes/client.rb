require 'socket'
require 'thread'
require 'json'

class Client

    PORT = 9956

    attr_accessor :queue

    def initialize(game_window, nickname, server_ip='localhost', port=PORT)
      @game_window = game_window
      @server = TCPSocket.new server_ip, port
      @nickname = nickname
      @queue = Queue.new
      @response = nil

      listen
      connect_to_server
    end

    def update(snake)
      msg = {
        id: @nickname,
        location: {
          x: snake.x,
          y: snake.y
        },
        length: snake.length
      }
      @server.puts JSON.generate msg
    end

    private
    def connect_to_server
      connection_data = {
        id: @nickname,
        login: true
      }
      @server.puts JSON.generate(connection_data)
    end

    def listen
      @response = Thread.new do
        loop do
          begin
            msg = JSON.parse(@server.gets.chomp)
            if msg.has_key?("id") and msg.has_key?("location")
              @queue << msg
            end
          rescue
            puts "Failed to parse server message: #{msg}"
          end
        end
      end
    end

end
