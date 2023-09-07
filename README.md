# interfacing serato with processing

## description
systems to interfacing serator for visualisation of Dj data

### objectives
interface with history file
update processing in realtime from history file

interface with audio out from serato
realtime interface to contol audio through processing

interface with midi data and explore this

## setup
For win10:
1. Install php 8, I used chocolatey package manager <br>
		https://chocolatey.org/install, then in a shell:  <br>
		`choco install php`
2. Download ben-xo/sslscrobbler <br>
		`git clone https://github.com/ben-xo/sslscrobbler.git`
3. Remove the ; to uncomment the following in php.ini ("C:\tools\php82\php.ini"). Open it in a text file and search for these
		`extension=socket` <br>
		`extension=mbstring` <br>
the socket is for json, mbstring is for text conversion
4. Install Serato
		https://serato.com/dj/pro/downloads

## running
1. run sslscrobbler with Json flag from a shell <br>
	`php "C:\Documents and Settings\ben\Desktop\historyreader.php" -J 8080`
2. Start Serato 
3. Start Processing sketch <br>

loading tracks into should update the json, mousePressed() in processing pulls it from a server established from historyreader.php
	
## useful info
https://support.serato.com/hc/en-us/articles/204022904-What-is-in-the-Serato-folder-

someone going on about midi output through an xml
https://serato.com/forum/discussion/1066513
