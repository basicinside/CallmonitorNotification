#!/usr/bin/env ruby

require 'phonedirectory'
require 'notify'
require "socket"

class CallmonitorNotificationApp
	def initialize
		@status = "disconnect"
		connect
	end	

	def status 
		@status
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
				File.open("callmonitor.online", "a")
				puts "addr: " + @s.addr.join(":")
				puts "peer: " + @s.peeraddr.join(":")
				@status = "connected"
				listen
				@s.close
			end
			@status = "disconnect"
			sleep 30
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
			phonebook.add(number, "unknown")
			name = number
		end
		notifyCall(name)
	end

	def notifyCall(caller)
		callerNotify = Notify.new
		callerNotify.setIcon(File.expand_path("phone.png"))
		callerNotify.setTitle("incoming Call")
		callerNotify.setText("#{caller} invokes.")
		callerNotify.display
	end
end

CallmonitorNotificationApp.new
