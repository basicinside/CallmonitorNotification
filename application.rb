#!/usr/bin/env ruby

require 'phonedirectory'
require 'notify'
require "socket"

class CallmonitorNotificationApp
	def initialize
		connect
	end	
				
 	def connect
		while true
			host="fritz.box"
			puts "Trying " + host + " ..."
			error = false
			begin
				@s = TCPsocket.open(host, 1012)
				rescue SocketError
				error = true
			end
			if error == false
				puts "addr: " + @s.addr.join(":")
				puts "peer: " + @s.peeraddr.join(":")
				listen
				@s.close
			end
			system 'sleep 30'
		end
	end

	def listen	
		while line = @s.readline
			puts "Received " + line
  		entry =	line.chomp.split(";")
			if entry[1] == "RING"
				incomingCall(entry[3])				
			end
		end
	end
	
	def incomingCall(number)
		phonebook = PhoneDirectory.new
		if (name = phonebook.searchNumber(number)) == ""
			phonebook.add(number, "unknown, but registered caller")
			name = number
		end
		notifyCall(name)
	end

	def notifyCall(caller)
		callerNotify = Notify.new
		callerNotify.setIcon("/usr/share/pixmaps/pidgin/emotes/default/phone.png")
		callerNotify.setTitle("incoming Call")
		callerNotify.setText("#{caller} invokes you.")
		callerNotify.display
	end
end

CallmonitorNotificationApp.new

