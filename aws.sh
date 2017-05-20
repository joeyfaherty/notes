#http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html

#list cli config
ls  ~/.aws

#list cli credentials
ll ~/.aws/credentials

#profiles
aws configure with the --profile user2
# edit your credentials here
vi ~/.aws/credentials
[default]
aws_access_key_id=<ACCESS_KEY>
aws_secret_access_key=<SECRET_KEY>

[user2]
aws_access_key_id=<ACCESS_KEY>
aws_secret_access_key=<SECRET_KEY>

# copy a file from local to s3 using cli
aws s3 cp ~/.bashrc s3://logs-flume --profile joey-personal
aws s3 cp ~/.bashrc s3://test-poc-bucket-joey/events

errors:
1 add hadoop common jar to flume-env
2 add haddop-aws jar to flume-env as it doesnt come by default
3 mac host name needs to be mapped to 127.0.0.1 in /etc/hosts for kafka console producer to work
4 for custom interceptors the jar needs to be copied into $FLUME_HOME/lib
5 copy foxyproxy.xml directly into folder and replace with default file /Users/joey/Library/Application Support/Firefox/Profiles/wpxjsroi.default

# connect to ui apps (zepplin, history server, etc)
ssh -i ~/workspace/aws-access-keys/ec2-keypairs/joey-pair.pem -ND 8157 hadoop@ec2-34-209-18-207.us-west-2.compute.amazonaws.com
do point 5 above
aws console should update to hyperlinks

# spark history
http://ec2-34-209-18-207.us-west-2.compute.amazonaws.com:18080/
# ganglia
http://ec2-34-209-18-207.us-west-2.compute.amazonaws.com/ganglia/

# copy from local to emr
scp -i ~/workspace/aws-access-keys/ec2-keypairs/joey-pair.pem /Users/joey/workspace/abc/* hadoop@ec2-52-37-14-12.us-west-2.compute.amazonaws.com:~/
