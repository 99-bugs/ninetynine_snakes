require 'socket'
require 'thread'
require 'json'

class Client

    PORT = 9956

    attr_accessor :queue

    def initialize(game, nickname, server_ip = 'localhost')
        @game = game
        @server = TCPSocket.new server_ip, PORT
        @nickname = nickname
        @nickname = rand(10000000)

        @queue = Queue.new

        @response = nil
        listen

        connection_data = {
            id: @nickname,
            login: true
        }

        @server.puts JSON.generate(connection_data)
        # @response.join
    end

    def update(snake)
        msg = {
            id: @nickname,
            location: {
                x: snake.x,
                y: snake.y
                }
            }
        @server.puts JSON.generate msg
    end

    def listen
      @response = Thread.new do
        loop {
            begin
                msg = JSON.parse(@server.gets.chomp)
                if msg.has_key?("id") and msg.has_key?("location")
                    @queue << msg
                end
            rescue

            end
        }
      end
    end

end
