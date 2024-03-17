# <div align = "center"> Bandit Over The Wire WriteUps </div>

## Level 0->1
This level is about how to login into the game. We need to ssh to the bandit server at port 2220 to the user bandit0 which is at [bandit.labs.overthewire.org](bandit.labs.overthewire.org) with the password **bandit0**.  
This can be done by using the ssh command as follows
```  
ssh bandit0@bandit.labs.overthewire.org -p 2220
```
The password to the next level is present inside a file called readme which is present inside the home directory. We can look for the file using the `ls` command and read it using the `cat` command.
```
ls
cat readme
```

## Level 1->2
This level is about how to work with a dashed filename. A file with the name - contains the password to the next level.  
To read these sort of files we need to use `./` which indicates that these are files present in the current `.` directory.  
```
cat ./-
```

## Level 2->3
The password to the next level is containd in a file whose name conatins spaces.  
There are two ways to work with these sort of files, first by using quotes and second by using escape key sequences
```
cat "spaces in this filename"
```
or
```
cat spaces\ in\ this\ filename
```

## Level 3->4
The password to the next level is present in a hidden file inside the **inhere** directory.  
So first we need to go inside the directory using `cd` command.  
```
cd inhere
```
Now, hidden files are not visible directly by ls but instead use `ls -la`. This command shows all the files in a directory and also their permissions and owners.  
Thus after knowing the name we can read the file.  
```
ls -la
cat .hidden
```

## Level 4->5
The password to the next level is stored inside the only human readable file inside the inhhere directory.  
To search for it we can use the `file` command as it finds the type of the file using the data prsesnt inside and not the extension so we can just check whichever file will have the ASCII Text will be the password file.  
Note as the file names begin with -, we would have to use `./`.
This can be done using  
```
cd inhere
file ./*
```
`*` means that all the files in the current directory will be checked. This way only -file07 will contain ASCII Text which can be read using  
```
cat ./-file07
```

## Level 5->6
The password for the next level is stored inside one of the files stored inside the directories present in the inhere directory.  
Its size is 1033 bytes, is human readable and non executable. Files can be searched using the `find` command with attributes like `-size`.  
We can get the required file just by putting the size conditions as there are no other files with the same size.  
The file comes out to be `./maybehere07/.file2` which can be read using the cat command.
```
cd inhere
find ./ -size 1033c
cat ./maybehere07/.file2
```

## Level 6->7
The password for the next level is stored in a file whose size is 33 bytes, owned by user bandit7 and group bandit6.  
This type of file can be searched by the `find` command along with its fields like `-size`, `-user` and `-group`.  They have also said that it is present somewhere on the server so we heve to search from `/` root directory.  
```
find / -size 33c -user bandit7 -group bandit6
```
This command works but it will also yeild many wrong outputs which will say permissions denied. To prevent that we will use `2>/dev/null`.  
It represents a virtual devices where we will send all our wrong outputs and only the correct one will reach us.  The file comes out to be `/var/lib/dpkg/info/bandit7.password` which can be read using cat.
```
find / -size 33c -user bandit7 -group bandit6 2>/dev/null
cat /var/lib/dpkg/info/bandit7.password
``` 

## Level 7->8
The password for the next level is strored in data.txt against the word millionth. This can be directly searched using the `grep` command.  
It will display all the lines which contain the word millionth.  
```
grep millionth data.txt
```

## Level 8->9
The password to the next level is the only uniquely occuring line in the file data.txt.  
These types of searches can be directly made using the `sort` command.  
This command will show us the only unique line in the file.  
```
sort data.txt | uniq -u
```

## Level 9->10
The next password is stored in a file wich has only a few human readable sections and it is preceded by several =.  
The `-a` flag in the grep command allows us to read binary files as text files. We can search for the line which contains several = and observe for the password.
The `=..=` signifies an unspecified number of =.   
```
grep -a "=..=" data.txt
```

## Level 10->11
The password is in data.txt which contains base64 encoded data.  
The `base64` command is used to encode data and the `base64 -d` command is used to decode data back to text.  
So we can pipe the content of data into the decoding command as follows
```
cat data.txt | base64 -d
```

## Level 11->12
The password for the next level is stored in data.txt but it is `rot16` encrypted i.e. all the alphabets have been rotated by 13 places.  
For doing these types of operations with text we use the `tr` command.  
The characters from A-Z will become N-Z_A-M (shifted 13 positions).
```
cat data.txt | tr "A-Za-z" "N-ZA-Mn-za-m"
```

## Level 12->13
In this level first we had an hexdump which needed to be converted back to original format, then we need to go through various compression formats to reach the original file.  
If datax is a file then the following command will be used to identify its current format and then its respective decompression command can be used
```
file datax
```
To rename the file to its format we can use
```
mv -v datax datax.tar
mv -v datax datax.gz
mv -v datax datax.bz2
```
Now to revert the hexdump we use 
```
xxd -r data.txt
```
To decompress gzip we can use
```
gzip -d datax.gz
```
To decompress bzip2
```
bzip2 -d datax.bz2
```
And to decompress POSIX tar
```
tar --format=posix -xvf datax.tar
```

The specific order is `Hexdump`->`gzip`->`bzip2`->`gzip`->`Posix tar`->`Posix tar`->`bzip2`->`Posix tar`->`gzip`->`Text file`

## Level 13->14
This level provides an ssh private key which can be used to ssh onto level 14. The actual password to level 14 is stored in `/etc/bandit_pass/bandit14`.  
So as to ssh we can use the following command
```
ssh -i sshkey.private bandit14@localhost -p 2220
cat /etc/bandit_pass/bandit14
```

## Level 14->15
The password for the next level can be found by submitting the current one to port 30000.  
For this we can use the netcat `nc` command
```
nc localhost 30000
```
It will automatically prompt for the input and return the password. `nc` generates a TCP connection to that port on the localhost ip.

## Level 15->16
The password can be aquired be submitting the current password to port 30001 using ssl encryption.  
Here we needed to use `openssl` command to encrypt the key and send the encrypted key to port 30001.  
We also had to use `-ign_eof` so that openssl keeps the connection open even after the end of file character is found instead of closing it.
```
openssl s_client -connect localhost:30001 -ign_eof
```
After this command a prompt will come where after submitting the current password we will get the next one.

## Level 16->17
This level has 4 tasks. First we need to find all port that are open and have ssl encryption using `nmap` command. The `-sV` flag is used to detect the service versions running at the ports
```
nmap -sV -p 31000-32000 localhost
```
Now we will use the `netstat` command to look for listening port
```
netstat -a
```
We can notice that there is only one common port `31790`. So now we can send the encrypted key to that port. 
```
echo "JQttfApK4SeyHwDlI9SXGR50qclOAil1" | openssl s_client -connect localhost:31790 -ign_eof
```
The port returns us a private key to ssh to level 17.
So as to use this private key we need to save it inside a file which can be done using vim, and then change its permissions so that others can not access it (400) using ` chmod` command.
```
touch private.key
chmode 400 private.key
```
Now we can just ssh to the next level using the private key file as follow
```
ssh -i private.key bandit17@localhost -p 2220
```

## Level 17->18
There are two files present password.old and password.new and password is the only different line in password.new.  
We just need to compair two files using `diff` command, `--suppress-common-lines` removes all those lines which are common between the two files. 
```
diff --suppress-common-lines passwords.old passwords.new
```

## Level 18->19
The password is in the filr readme but the connection terminates as soon as we login.  
Due to this we can not run commands, but we can use `scp` command to directly download the file to our system.
The `-r` means that it will download all the files present inside all folders recursively. It is not necessary here but is a good practices to use. 
```
scp -r -P 2220 bandit18@51.20.13.48:~/readme .
```

## Level 19->20
We have a setuid file which allows us to run commands as the user bandit20. The password is located in `/etc/bandit_pass/bandit20`.  
So to read the password we can use the cat command directly using the bandit20-do binary file. 
```
./bandit20-do cat  /etc/bandit_pass/bandit20
```

## Level 20->21
In this level we are given a binary file `suconnect` which connects to a port and if it recieves the password of the current level then it sends back the password to the next level.
For this we would require two terminals. The `nc` command can act as a listening server using the `-l` flag.
In one terminal we have to open the listening server on any port say 12035 using 
```
nc -lvp 12035
```
In the other terminal run the the `suconnect` file so that a connection establishes.
```
./suconnect 12035
```
Now back to the first terminal, if we submit the password of the current level we will get the next password.

























