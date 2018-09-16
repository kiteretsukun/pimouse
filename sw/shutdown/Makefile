install: 
	cp shutdown_sw.bash /etc/init.d/raspimouse_shutdown
	chmod +x /etc/init.d/raspimouse_shutdown
	update-rc.d raspimouse_shutdown defaults 

uninstall:
	update-rc.d raspimouse_shutdown remove 	
	rm /etc/init.d/raspimouse_shutdown
