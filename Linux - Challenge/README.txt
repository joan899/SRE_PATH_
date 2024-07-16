First Part / Creating users and assigning them permissions:
	1- Add an user called devuser and asign it a secure password.
		Command to add an user: sudo useradd devuser
		Command to asign a password to the user: sudo passwd devuser (then the system will ask you to provide a secure password and confirm it)
	2- Create a dev group:
		Creating a group called developers: sudo groupadd developers
		Adding 'devuser' user to the 'developers' group: sudo usermod -aG developers devuser
	3- Project directory:
		Creating the directory: mkdir -p opt/devproject
		Changing the properties of the directory in order to belongs to the devuser user and the developers group: sudo chown devuser:developers opt/developers
		Adding permissions of reading, writing and executing to the owner and the group, but other users will only have permissions of reading and executing: sudo chown 775 opt/developers

Second Part / Creating a System Maintenance Script:
	Creating the script file: nano system_maintenance.sh
	1. System update
	2. Removing unnecessary packages and cleaing cache memory
	3. Checking the disk status 
	4. Listing the active users currently
	5. Show the 5 proccesses that are consuming the CPU most

	#!/bin/bash

	# below command will Update package lists
	sudo apt update >> maintenance_output.txt
	
	# below command will Remove unnecessary packages and dependencies for good memory management
	sudo apt autoremove -y >> maintenance_output.txt

	# below command will Clean package cache
	sudo apt clean -y >> maintenance_output.txt

	# checking disk status
	df -h  >> maintenance_output.txt
	
	#listing the active users
	users >> maintenance_output.txt
	
	#listing the CPU proccesses 
	ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 >> maintenance_output.txt
	
	
	---------------------------------------------------------------------------------------------------------
	Making the script executable: chmod +x system_maintenance.sh

	Running the script: ./system_maintenance.sh
	
	