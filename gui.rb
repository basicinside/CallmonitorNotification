require 'gtk2'
require 'fileutils'

class GUIApplication
	def initialize()
		tray = Gtk::StatusIcon.new
		tray.file = File.expand_path("phone-disabled.png")
		tray.tooltip = "fritz!box callmonitor"  

		menu = Gtk::Menu.new
		menuQuit = Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
		menuQuit.signal_connect("activate") {|widget, event| Gtk.main_quit }
		menu.append(menuQuit)
		tray.signal_connect("popup-menu") {|widget, button, time|
    if button == 3
        menu.show_all
        menu.popup(nil, nil, button, time)        
    end
		}
		GLib::Timeout.add_seconds(3) { 
			fetchGUIThread = nil
			if fetchGUIThread.instance_of? Thread
					fetchGUIThread.terminate
					fetchGUIThread = nil		
			else
				fetchGUIThread = Thread.new {
					while !File.exists?("callmonitor.online")
						sleep 10
					end
					tray.file = File.expand_path("phone.png")
					FileUtils.remove_file(File.expand_path("callmonitor.online"), true)
				}
			end
		}
		Gtk.main  
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
GUIApplication.new

