# <div align = "center"> Fracz Git exercises WriteUps </div>

## Commit one file
Here we are given two files and we need to commit only one of them.  
For this we can directly mention one file as follows
```
git add A.txt
git commit -m "Lvl1"
git verify
```

## Commit-one-file-staged
Here two files are added to the staging area but we want to commit only one.  
We can view the staged files using
```
git status
```
and can remove a file say B.txt and commit the changes as follows
```
git rm --cached -r B.txt
git commit -m "lvl2"
git verify
```

## Ignore-them
In this we had to use .gitignore to ignore all files with `.exe`, `.o` and `.jar` extensions and also ignore the `libraries` folder.  
An important thing to note is that .gitignore only works for files which are not added to the staging area.
So we can start by creating a file and adding the respective filenames.
```
touch .gitignore
```
And then add the files into it.
> libraries/  
> *.exe  
> *.o  
> *.jar  

```
git add .
git commit -m "lvl3"
git verify
```

## Chase-branch
In this level we were given two branches,one chase and other escaped which was two commits ahead.  
We want that the chase branch should point to the same commit as the escaped branch, thus we have to merge the branch with chase.  
```
git checkout chase
git merge escaped
git verify
```

## Merge-conflict
In this level we were given two branches, one had a file containing 2+?=5 and the other had that file containing ?+3=5.  
When we merge branch using  
```
git merge another-piece-of-work 
```
We will have to manually select what text to keep and what to remove.  
After successfully making the changes we can commit the changes as follows
```
git add .
git commit -m "lvl5"
git verify
```

## Save-your-work
In this level we had some files which we were working on and then we had to save the state of the work without making a commit to go back to the last commit and make a bug fix.  
This can be done by 
```
git stash
```
Now we come back to our last commit and we can make the changes needed.
```
git add .
git commit -m "lvl6.1"
```
After making the commit we can come back to our work using 
```
git stash pop
```
And complete the work after which we can make the final commit
 ```
git add .
git commit -m "lvl6.2"
```

## Change-branch-history
In this level we have two branches, change-branch-history and hot-bugfix.  
We want that the change made on hot-bugfix should also appear on change-branch-history, for this we can use the `rebase` command.
On branch change-branch-history
```
git rebase hot-bugfix
git verify
```

## Remove-ignored
In this level we are given a file which is tracked but now we dont want it to be tracked and is also mentioned in .gitignore .  
For this we can remove the file using
```
git rm --cached -r ignored.txt
git add .
git commit -m "lvl8"
git verify
```

## Case-sensitive-filename
In this we have to change the name of a file which is being tracked.  
Fo this we can just rename the file using `git mv` 
```
git mv File.txt file.txt
git commit -m"lvl9"
git verify
```

## Fix-typo
In this level we have a file which is edited in last commit but has a typo.  
We want that no new commit should be made and correction should be done in last commit.  
To get these results we will first edit the file as needed then run the following command
```
git add .
git commit --amend -m "Add Hello world"
git verify
```
Note: The name of the commit should stay the same.  

## Forge-date
In this qlevel we have to change the commit date of the last commit to year 1987.  
This can be done using the `amend` command as follow
```
git commit --amend --date="Wed Feb 16 14:00 1987 +0000" --no-edit
git verify
```

## Fix-old-typo
In this experiment we had to edit a typo which was made in an older commit.  
To solve this we can use the `rebase` command with the commit name which we want to edit. 
```
git rebase --interactive c6a06f8~
```
Now we are back to that commit, here we can correct the typo.
```
git add .
git commit --amend 
```
We have fixed the typo, we now have to go back to the latest commit and resolve merge commits.
```
git rebase --continue
git add .
git rebase --continue
git verify
```


