# interfacing serato with processing

## description
stuff for visualisation/VJ software direct from serato

### objectives
interface with history file
update processing in realtime from history file

interface with audio out from serato
realtime interface to contol audio through processing

interface with midi data and explore this

## setup
For win10:
1. Install php 8, I used chocolatey package manager
		`code`choco install php
2. Download ben-xo/sslscrobbler
		git clone https://github.com/ben-xo/sslscrobbler.git
3. Remove the ; to uncomment the following in php.ini ("C:\tools\php82\php.ini"). Open it in a text file and search for these
		extension=socket
		extension=mbstring
4. Install Serato
		https://serato.com/dj/pro/downloads

## running
1. run sslscrobbler with Json flag from a shell
	$ php "C:\Documents and Settings\ben\Desktop\historyreader.php"
2. Start serato 
3. Start processing sketch
	
## useful info
https://support.serato.com/hc/en-us/articles/204022904-What-is-in-the-Serato-folder-

someone going on about midi output through an xml
https://serato.com/forum/discussion/1066513
