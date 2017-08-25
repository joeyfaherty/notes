#git config
git config --global user.name joey
git config --global user.email joey.faherty@home.com
git config --global --list

#switch to another branch
git branch -v -a
git fetch
git checkout joey/feature/US-460449-ango

#list all branches, * indicates the branch you have currently checked out (ie. the branch that HEAD points to).
git br -a

#clone a repository
git clone https://github.com/apache/activemq-artemis.git

# New US: create a feature branch off master, then create local task branch from feature branch
# creates new local branch off master
git checkout -b feature/US-460449-ango master
# push local copy immidiately upstream
git push -u origin feature/US-460449-ango
# creates a new local branch off remote feature branch newly created
git checkout -b joey/feature/US-460449-ango origin/feature/US-460449-ango

# compare/diff between two branches
git diff branch_1..branch_2

#revert a locally modifi0	ed file
git checkout myapp/pom.xml

#create a new dev branch and push to remote
git br -a
git add titan-artemis-dockerized/
git status
git commit -am "[US-450252] modify artemis-docker image to use -v to mount local data & config folders"
git push -u origin joey/feature/US-450252--dockerized
git br -a

# shows which local (untracked) files will be removed from my current Git branch?
git clean -f -n
# removes local untracked files from branch***beware
git clean -f 

git fetch <remote> // Download all changes from <remote>, but dont integrate into HEAD
git pull <remote> <branch> // Download changes and directly merge/integrate into HEAD

# commit message
[US-460449]

# pull changes from another branch into your current branch
git pull origin iranna/feature/US-460449-using-arango

# force push commit
git push -f origin joey/feature/US-460449--using-arango

# delete a LOCAL branch 
git branch -d joey/feature/US-450252-artemis-dockerized

# delete a REMOTE branch 
git push origin --delete origin/joey/feature/US-450252-artemis-dockerized

# get all logs of a specific branch
git log origin/feature/US450252-user-account-msg

# show modified files from a certain commit 
git show --name-only 69343b12ba94492426f5f95265ab62cd8acaa57b


# rebase
git checkout joey/feature
git fetch --all
git rebase origin/feature/US-45939466

#
git log HEAD~4

# reset current branch 
git checkout mybranch
git reset --hard origin/mybranch

# stash
git stash #stashes current changes and resets to pr maevious commit
git stash list #shows list of stashes
git stash apply #goes back to stash state of working directory. Specify a stash by git stash apply stash@{2}

# rebase
git checkout feature/US-463493-postgres-setup-and-config
git pull
git checkout joey/feature/US-463493-postgres-setup-and-config
git rebase feature
git add/git rebase --continue
git push -f origin joey/feature
delete local branch?
checkout branch again?

# squash
git rebase -i HEAD~3

# rename a branch
git branch -m old_branch new_branch

# cherrypick a commit from one branch to yours
git cherry-pick 0a93a81639f76107fe9db95ef35e4197ed02c8e0
git add/ git cherry-pick --continue 

# pipe the diff to a file for later inspection
git diff --color > diff.txt

# list all remote tags
git ls-remote --tags origin

# show contents of a file from a specific commit
git show HEAD~4:index.html

# show changed files froma certain COMMIT_SHA
git show COMMIT_SHA

# add a file to .gitignore
echo 'filename' >> .gitignore

#f2master merge request, rebase feature branch
git rebase -i origin/master

# Get info about file statistics after a commit
git log --pretty=format:'[%h] %an %s' --date=short --numstat

# Have a more convenient overview of your commit, refering to the pointers of the different branches
git log --oneline --decorate

# It's possible to add custom git commands to ~/.gitconfig file content:
 [alias]
st = status
ci = commit
br = branch
co = checkout
df = diff
dc = diff --cached
lg = log -p
stats = log --pretty=format:'[%h] %ad %an %s' --date=short --numstat 
lol = log --graph --decorate --pretty=oneline --abbrev-commit
lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
ls = ls-files

git config --global pull.rebase true

git remote set-url origin git@github.com/username/reponame.git

# revert a current commit and have all the files in the stage as just befire the commit happened
git reset HEAD~

git remote add origin git@github.com:JGHInternet/tillyoudrop
git push -u origin master

# count remote branches
git branch -a | wc -l

# git autocomplete mac
# download this file to your home directory
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# add this to your bash_profile so that it will use the downloaded file
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# remote branch clean up
# delete all branches except master
git branch -a --merged remotes/origin/master | grep -v master | grep "remotes/origin/" | cut -d "/" -f 3- | xargs -n 1 git push --delete origin
# To do a dry run :-)
git branch -a --merged remotes/origin/master | grep -v master | grep "remotes/origin/" | cut -d "/" -f 3- | xargs -n 1 cat
