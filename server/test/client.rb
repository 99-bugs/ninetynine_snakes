require 'socket'

s = TCPSocket.new 'localhost', 9956

while line = s.gets # Read lines from socket
  puts line         # and print them
end

s.close             # close socket when done
