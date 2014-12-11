*******  HOW GIT WORKS  *******
working directory - staging area - git repo

working directory: files you see on your harddrive
staging area: a file, generally contained in your Git directory, that stores information about what will go into your next commit.
git repository - the files that are here are safely stored within the repository. It is actually relatively difficult removing them by accident once they are here.


*******  DOWNLOADING FILES  *******
# TODO: creating own repo
git clone: creates working directory and a valid git repository

git pull: downloads all files and file changes from remote repository (like the one on github)


*******  UPLOADING FILES  *******

# to add new file to git:
git add file1.txt	# puts file1.txt to staging area

# to upload all file changes to github:
git commit -am "I just added some files..."  #puts all tracked files to staging area AND commits them
git push  # uploads commited files to your remote (github or something)

# git push uploads all files to the remote git repository called origin (the one on github), specifically to branch master, if nothing else is sepcified. I.e.
# git push
# does the same as
# git push origin master


# to upload all file changes to github - alternative and WORSE solution:
git add .	# adds ALL files to staging area, even junk and hidden files
git commit -m "I just added some files..."  # commits ALL files in the staging area
git push


# remove file from git so that it's no longer tracked:
git rm file1.txt
# move file to another place within git repository
git mv file1.txt


*******  RESOLVING CONFLICTS  *******
# conflicts happen if person A pushes changes, and person B does not pull, but instead commits his own changes (locally), and THEN tries to push.
# when person B tries git push, he gets the error; "Updates were rejected because the remote contains work that you do not have locally. You may want to first integrate the remote changes (e.g., 'git pull ...') before pushing again."
# So person B has to git pull, obviously. However, during git pull, person B will see the following error:
# "CONFLICT (content): Merge conflict in .... Automatic merge failed; fix conflicts and then commit the result."

# To resolve a conflict, you will have to use a merge tool and manually delete the changes you don't want to keep. Start the manual merging process using the mergetool kdiff3:

git mergetool --tool=kdiff3

# after successful manual merge, run:
git commit -am "some message"
git push

# To allow other people to push to your github repository: Settings - Add them as Collaborators

******  RETURNING TO PREVIOUS COMMITS  ******

git checkout <commit_ID>  # return working directory to a previous state, for example:
git checkout c9cda6dc4fd35bf4640f534af4a507f1092fcbce
git checkout master		# return from that previous state back to the presence


*******  OTHER USEFUL COMMANDS  ********
git status	 # Is everything ok?
git log		 # What were the last commit messages and commit IDs?


# TODO:
******  BRANCHING  *******
# not covered here, sorry

******  STASHING  ******


******  REBASE vs. PULL  ******

