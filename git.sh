#git config
git config --global user.name joey
git config --global user.email joey.faherty@domain.com
git config --global --list

#git requires username and password for every interaction with remote repo
git remote set-url origin git@github.com:username/repo.git

#switch to another branch
git branch -v -a
git fetch
git checkout user/feature/branch-name

#list all branches, * indicates the branch you have currently checked out (ie. the branch that HEAD points to).
git br -a

#clone a repository
git clone https://github.com/apache/activemq-artemis.git

#revert a locally modified file
git checkout kafka-home/pom.xml

#create a new local branch & switch to it at the same time
git checkout -b json-consumer

#create a new dev branch and push to remote
git br -a
git add directory/
git status
git commit
git push -u origin joey/feature/branch-name
git br -a

#merge from a branch back to master
git checkout master
git pull origin master
git merge test
git push origin master

#link local and remote repositories before remote push
git remote add origin git@github.com:username/reponame.git
