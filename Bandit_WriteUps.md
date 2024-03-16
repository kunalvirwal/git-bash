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


























