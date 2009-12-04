require 'gtk2'
require 'fileutils'

class CallGUI
	def initialize()
		statusIcon = Gtk::StatusIcon.new
		if File.exists? "phone.png"
			statusIcon.file = File.expand_path("phone-disabled.png")
		else
			statusIcon.stock = Gtk::Stock::SELECT_COLOR
		end
		statusIcon.tooltip = "fritz!box callmonitor"  
		#statusIcon.set_visible true
		puts "build menu"
		menu = Gtk::Menu.new
		menuQuit = Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
		menuQuit.signal_connect("activate") {|widget, event| Gtk.main_quit }
		menu.append(menuQuit)
		#menu.append(statusIcon)
		statusIcon.signal_connect("popup-menu") {|widget, button, time|
    if button == 3
        menu.show_all
        menu.popup(nil, nil, button, time)        
    end
		}
		GLib::Timeout.add_seconds(3){ 
		puts "test"
		fetchGUIThread = nil
		if fetchGUIThread.instance_of? Thread
				fetchGUIThread.terminate
				fetchGUIThread = nil		
				puts "is Parent"
				
		else
			fetchGUIThread = Thread.new {
				#puts "in Thread"
				while !File.exists?("callmonitor.online")
					puts "GUI: Waiting for connection"
					sleep 10
					
				end
				statusIcon.file = File.expand_path("phone.png")
				FileUtils.remove_file(File.expand_path("callmonitor.online"), true)
				puts "File deleted"
				puts "GUI: Connection established"
			}
			puts "Thread was started"
			puts fetchGUIThread.status
		end
		}
		#puts "GTk running"
		Gtk.main  
		#puts "gtk quitted"
	end
end

fetchThread = nil
if fetchThread.instance_of? Thread
	fetchThread.terminate
	fetchThread = nil
else
	fetchThread = Thread.new do
		require 'application'
	end
end				
CallGUI.new

