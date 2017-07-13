Reading file permissions unix:
Three permission triads
first triad 	what the owner can do
second triad 	what the group members can do
third triad 	what other users can do
Each triad
first character 	r: readable
second character 	w: writable
third character 	x: executable

    -rwxr-xr-x: a regular file whose user class has full permissions and whose group and others classes have only the read and execute permissions.
    crw-rw-r--: a character special file whose user and group classes have the read and write permissions and whose others class has only the read permission.
    dr-x------: a directory whose user class has read and execute permissions and whose group and others classes have no permissions.


	Symbolic 	Numeric English
	---------- 	0000 	no permissions
	---x--x--x 	0111 	execute
	--w--w--w- 	0222 	write
	--wx-wx-wx 	0333 	write & execute
	-r--r--r-- 	0444 	read
	-r-xr-xr-x 	0555 	read & execute
	-rw-rw-rw- 	0666 	read & write
	-rwxrwxrwx 	0777 	read, write, & execute
	-rwxr----- 	0740 	user can read, write, & execute; group can only read; others have no permissions
