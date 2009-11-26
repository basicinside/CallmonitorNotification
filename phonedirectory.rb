class PhoneDirectory

	def initialize
		
	end

	def add(number, name)
		file = File.new("phonebook", "a")
		file.puts "#{number};#{name}"
		file.close
	end

	def searchNumber(num)
		if File.exists?("phonebook")
			f = File.open("phonebook", "r+")
			while entry = f.readline.chomp
				(number, name) = entry.split(";")
				if number == num
					return name
				end
			end
				""
		end
		""
		rescue EOFError
    	f.close	
		
	end

	

end
