TIL:
	- Ifrastructure as a code. Overview of various configuration management tools: Ansible, Chef, Puppet, SaltStack
        - Agent-Master vs serverless aproach. Pull and Push methods of operation
        - Ansible Intro and some examples
        - Bash shell self study project

Homework description:
Given: long one-liner
Task: to write 'nice' simple executable scrip

Scrip utilizes netstat utility to obtain connections info (ip/status).
User will input process name / PID as argument #1 ($1) when calling the script and should be able to recieve filtered output from netstat.
User can regulate the number of script output lines by passing argument #2 ($2). Should be integer > 0.
User might wish to recieve connection status information by passing "--show-status" as argument #3 ($3).   
Extra utilities used: sed, tr.
Script ties to obtain netname if organization name returns blank. Finaly sets Organization name to "noname" if recieves "" from both.  
Script calculates number of connection to organization.
Some user generated error processing included 
