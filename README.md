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
		https://chocolatey.org/install
		`choco install php`
2. Download ben-xo/sslscrobbler
		`git clone https://github.com/ben-xo/sslscrobbler.git`
3. Open php.ini ("C:\tools\php82\php.ini") in a text editor. 

4. Search for the following extension, uncomment (remove the ;) for:<br>
		`extension=socket` <br>
		`extension=mbstring` <br>

4. Install Serato
		https://serato.com/dj/pro/downloads

5. run sslscrobbler with Json flag from a shell:L <br>
	`php "C:\Desktop\sslscrobbler\historyreader.php" -J 8080`

6. Launch Serato, settings -> audio -> enable sharing thing

7. Start processing sketch, uncomment the line to work out the right mixer numbers


	
## useful info
https://support.serato.com/hc/en-us/articles/204022904-What-is-in-the-Serato-folder-

someone going on about midi output through an xml
https://serato.com/forum/discussion/1066513
