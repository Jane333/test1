*******  HOW GIT WORKS  *******
# working directory - staging area - git repo
# 
# working directory: files you see on your harddrive. Can hold "modified" files.
# staging area (= index): a file, generally contained in your Git directory, that stores information about what will go into your next commit. Holds "staged" files.
# git repository - the files that are here are safely stored within the repository. It is actually relatively difficult removing them by accident once they are here. Holds "commited" files.


*******  DOWNLOADING FILES  *******
git clone https://github.com/Jane333/test1.git # creates a local copy of the remote github repository
# or:
git init  # creates a new, empty repository in your current directory

git pull # downloads all files and file changes from remote repository (like the one on github)


*******  UPLOADING FILES  *******

# to add new file to git:
git add file1.txt	# puts file1.txt to staging area

# to upload all file changes to github:
git commit -am "I just added some files..."  # puts all tracked files to staging area AND commits them
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

git checkout <old_commit_ID>  # return working directory to a previous state, for example:
git checkout c9cda6dc4fd35bf4640f534af4a507f1092fcbce  # this will land you in a "detached HEAD" state, meaning: you can look around here, make changes, even commit them, but they will be lost after the next checkout unless you first create a new branch for these new commits: git checkout -b new_branch_name
git checkout master		# return from that previous state back to the presence

# or:
git reset --hard <old_commit_ID> # return working directory and HEAD to a previous state
git reset --hard <new_commit_ID> # return from that previous state back to the presence. Note: To do this, you need to write down the new_commit_ID BEFORE (!!!) you do git reset --hard <old_commit_ID>, because afterwards git won't show the new_commit_ID via git log anymore. You can only dig it up via: git reflog


*******  OTHER USEFUL COMMANDS  ********
git status	 # Is everything ok?
git log		 # What were the last commit messages and commit IDs?
git log origin/branch2  # to view github log of the branch "branch2"


******  BRANCHING  *******
# create new branch:
git branch <new_branch_name>

# go to this new branch:
git checkout <new_branch_name>

# go back to the old branch "master":
git checkout master

# list all existing branches:
git branch

# Delete the specified branch. This is a “safe” operation in that Git prevents you from deleting the branch if it has unmerged changes.
git branch -d <branch>

# Force delete the specified branch, even if it has unmerged changes. This is the command to use if you want to permanently throw away all of the commits associated with a particular line of development.
git branch -D <branch>

# While on branch master, merge branch <new_branch_name> into master. This will grab all the commits from <new_branch_name> and merge them into master (changing master and leaving new_branch_name unaffected):
git merge <new_branch_name>


******  STASHING  ******
# Scenario: You made some changes in your working directory, have not commited them yet, and want to pull the newest commits from github. But, your local changes stand in the way. Simply stash them away temporarily:
git stash

# pull the github commits:
git pull

#, and then get your stashed changes back, on top of the github commits:
git stash pop


******  REBASE vs. PULL  ******
# Purpose of both: merging two branches that have 'diverged' (each of them has commits the other one does not have).
# Difference: rebase results in a linear history, pull will let you see that the commits came from two different branches.

git pull <repo_name> <branch_name>  # This fetches all the remote commits to you and merges them with your stuff. if repo_name == origin and branch_name == master, they do not ned to be specified
git push # now you have both your own commits and those from github, nicely merged. You need to get them all to github, because after a pull, github still doesn't have YOUR commits.

# or:
git fetch --all  # to fetch all changes from remote repository
git rebase <repo_name>/<branch_name> # stashes away your commits, downloads remote commits from github, puts them on top of the commits you and github had in common, gets your commits that have been stashed away and puts them on top of the github commits.
git push -f  # now you need to upload your nicely linear commits from your local repo back to github. The force (-f) option is necesarry because a rebase changes commit IDs.


****** PULL REQUESTS  *******
#  - What are they good for?
#  - You are working on a software project. For that purpose, you forked the software project repository. Now you are done and want the professor to integrate your fork into the master branch of the software project. So you make a pull request, and the prof accepts it. 
#  - How do I make them?
#  - Go to github, to your fork, and look for anything read reads "Pull Requests". Keep clicking until it says the pull request has been submitted.


******* GLOSSARY  *******

--- HEAD---
# You can think of the HEAD as the "current branch". When you switch branches with git checkout, the HEAD revision changes to point to the tip of the new branch. (HEAD always points to the tip of the branch you are currently in)
# You can see what HEAD points to by doing:
cat .git/HEAD
# In my case, the output is:
ref: refs/heads/master
# It is possible for HEAD to refer to a specific revision that is not associated with a branch name. This situation is called a detached HEAD.

--- ORIGIN ---
# origin is the original remote repository, by convention it is the 'primary' centralized repository as well.
# When a repository is cloned, it has a default remote called origin that points to your fork on GitHub, not the original repository it was forked from. To keep track of the original repository, you need to add another remote named for example 'upstream'.

--- REMOTE ---
# When you clone your repo from github, the github repository is a "remote" of your local repository. You can add other remotes like this:

git remote add neues_upstream https://github.com/irgendein_github_name/ein_github_repo.git

# or display all existing remotes like this:

git remote -v