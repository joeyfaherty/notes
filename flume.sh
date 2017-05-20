# run flume
~/apps/apache-flume-1.7.0-bin/bin/flume-ng agent --conf ~/apps/apache-flume-1.7.0-bin/conf --conf-file joey_agent.conf --name joey_agent

# tail logs while running flume agent
tail -f logs/flume.log

