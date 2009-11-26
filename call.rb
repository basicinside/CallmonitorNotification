#!/usr/bin/env ruby

require 'phonedirectory'

class Call
	def initialize
		@status = "none"
		@caller = ""
		@listener = ""
	end

	def checkStatus
		require "socket"
 
		host="fritz.box"
		puts "Trying " + host + " ..."
		s = TCPsocket.open(host, 1012)
		puts "addr: " + s.addr.join(":")
		puts "peer: " + s.peeraddr.join(":")

		pd = PhoneDirectory.new
		while line = s.readline
		puts "Receive " + line
  	entry =	line.chomp.split(";")
		@status = entry[1]
		@caller = entry[3]
		if @status == "RING"
			@listener = entry[4]
			if (name = pd.searchNumber(@caller)) == ""
				pd.add(@caller, "unknown, but registered caller")
				name = @caller
			end
				system "notify-send \"Anrufmonitor\" \"#{name} ruft an.\""
		end
		end
		s.close

	end
	

end

a = Call.new
a.checkStatus
