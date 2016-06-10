require 'socket'
require 'json'

class Server

  PORT = 9956

  def initialize
    @server = TCPServer.new PORT # Server bound to port
    puts "#{Time.now} - Server listening on port #{PORT}"
    @connections = {}

    run
  end

  def run
      loop {
        Thread.start(@server.accept) do | client |
            content = JSON.parse(client.gets.chomp)
            if content["login"]
                puts "#{Time.now} - Client connected: #{content["id"]}"
                @connections[content["id"]] = client
                client.puts JSON.generate({message: "connected to server"})
                loop {
                    msg = client.gets.chomp
                    @connections.each do |other_id, other_client|
                        begin
                            other_client.puts msg unless other_id == content["id"]
                        rescue
                            #@connections.delete(client)
                            #puts "Client connection closed: #{content["id"]}"
                        end
                    end
                }
            end
        end
      }.join
    end
end


Server.new
