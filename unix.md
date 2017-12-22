# set env variables
export var=value

# grep from history and pipe to file
history | cat | grep "mvn" > mvn.txt

# ip/ localhost issues, add ip(s) to host file
vi /etc/host

# check which ports are in use
netstat -anp | grep 8080

# error:
# local postgres was running and occupying port 5432, then docker couldnt connect
telnet localhost 5432
ps -ef | grep postgres
service postgresql stop

# generate MD5 hashes a desired password
echo -n 'YOUR_PASSWORD' | openssl dgst -md5


#how to access your public key
cat ~/.ssh/id_rsa.pub or cat ~/.ssh/id_dsa.pub
You can list all the public keys you have by doing:
$ ls ~/.ssh/*.pub
#how to access your private key
cat ~/.ssh/id_rsa

# with ivan
less $(docker inspect -f '{{.LogPath}}' titan-server-joey )
# debug and see hwich files are opened
strace -tf -e open java -jar ../regression-0.0.2-SNAPSHOT.jar
strace -tf -e open java -jar ../regression-0.0.2-SNAPSHOT.jar 2>&1 | grep home
strace -tf -e open java -jar ../regression-0.0.2-SNAPSHOT.jar 2>&1 | egrep 'home|tmp'

# access perftestenv with kafka + java8
ssh ubuntu@ec2-52-50-69-211.eu-west-1.compute.amazonaws.com

# ssh tunnel to kafka manager
ssh -L 9000:localhost:9000 ubuntu@ec2-52-50-69-211.eu-west-1.compute.amazonaws.com

# ssh tunnel
ssh -L 9092:10.210.2.205:9092 ubuntu@ec2-52-50-69-211.eu-west-1.compute.amazonaws.com

# return from Ctl + Alt + F9 black screen!
Ctl + Alt + F7

find . -iname '*.tar.gz'

# check how long a current process is running, where $$ is the PID
ps -p "$$" -o etime=

# find all checkstyle files and delete them
rm $(find . -iname "*checkstyle-*.xml")

# get only current directory now full pwd
basename "$PWD"


# get only commits from a specific date
git log --oneline --since="2017-20-05T15:00:00-00:00" >> abc.txt

# grep and take only 2nd column and take only unique values
git log --oneline --since="2017-20-05T15:00:00-00:00" | awk '{print $2}' | grep "ETL-" | sort -u >> releaseJiraUS.txt


private key - chmod 440
public key - chmod 400


