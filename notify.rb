class Notify
	def initialize()

	end

	def display
		system "notify-send #{getIcon} '#{getTitle}' '#{getText}'"
	end

	def setTitle(title)
		@title = title		
	end

	def getTitle
		@title
	end

	def setIcon(icon)
		@icon = icon
	end

	def getIcon
		if File.exists?(@icon)
			"-i #{@icon}"
		else
			""
		end			
	end

	def setText(text)
		@text = text
	end

	def getText
		@text
	end
end
