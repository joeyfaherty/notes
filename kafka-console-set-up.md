1: download latest kafka & untar
https://www.apache.org/dyn/closer.cgi?path=/kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz
> tar -xzf kafka_2.11-0.9.0.0.tgz
> cd kafka_2.11-0.9.0.0

2: start the zookeeper server and kafka server
> bin/zookeeper-server-start.sh config/zookeeper.properties

> bin/kafka-server-start.sh config/server.properties

3: create a topic with single partition and only one replica
> bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic POC-test

4: list all topics
> bin/kafka-topics.sh --list --zookeeper localhost:2181

5: send some messages
> bin/kafka-console-producer.sh --broker-list localhost:9092 --topic POC-test
[input some text, each line is a new msg by default]

6: start a consumer in another terminal
> bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic POC-test --from-beginning
[you should see all messages, also new messages if you create new messages in the producer]

7: set up a multi broker cluster
7.1 First make a config file for each of the brokers:

> cp config/server.properties config/server-1.properties
> cp config/server.properties config/server-2.properties

7.2 Edit these new files and set the following properties:

config/server-1.properties:
    broker.id=1
    listeners=change_port
    port=9093
    log.dir=/tmp/kafka-logs-1

config/server-2.properties:
    broker.id=2
    listeners=change_port
    port=9094
    log.dir=/tmp/kafka-logs-2

7.3 start two new zookeeper nodes:
> bin/kafka-server-start.sh config/server-1.properties &
...
> bin/kafka-server-start.sh config/server-2.properties &
...

7.4
Create a new topic with a replication factor of three: [for a replication-factor of 3, you need 3 running brokers]
> bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replicated-topic

7.5
Check which brokers are doing what in your cluster:
> bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic


Output: 
Topic:my-replicated-topic	PartitionCount:1	ReplicationFactor:3	Configs:
	Topic: my-replicated-topic	Partition: 0	Leader: 1	Replicas: 1,2,0	Isr: 1,2,0

    "leader" is the node responsible for all reads and writes for the given partition. Each node will be the leader for a randomly selected portion of the partitions.
    "replicas" is the list of nodes that replicate the log for this partition regardless of whether they are the leader or even if they are currently alive.
    "isr" is the set of "in-sync" replicas. This is the subset of the replicas list that is currently alive and caught-up to the leader. 

7.6 publish again
> bin/kafka-console-producer.sh --broker-list localhost:9092 --topic my-replicated-topic

7.7 consume again
bin/kafka-console-consumer.sh --zookeeper localhost:2181 --from-beginning --topic my-replicated-topic

7.8 fault tolerence, Broker 1 was acting as the leader so let's kill it:
> ps | grep server-1.properties
> kill -9 7564

7.9 see that the leadership has switched to one of the slaves and node 1 is no longer in the in-sync replica set
> bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic my-replicated-topic
Topic:my-replicated-topic	PartitionCount:1	ReplicationFactor:3	Configs:
	Topic: my-replicated-topic	Partition: 0	Leader: 2	Replicas: 1,2,0	Isr: 2,0


7.10 all messages are still available for consumption even though that originally took the writes is down
> bin/kafka-console-consumer.sh --zookeeper localhost:2181 --from-beginning --topic my-replicated-topic
...
hello message 1
testing message 2

Notes/errors:
check for running kafka processes
> ps aux | grep kafka
Error: file peermission
> rm -rf /tmp/kafka-logs/.lock

ref: 
http://kafka.apache.org/documentation.html#quickstart

Kafka Java Consumer Hello Word:
- create a java consumer (basic below)
- start a producer as above with same topic
- run consumer (java)
- run producer (script)
- send messages from prodcuer console
- see messages in IDE console

import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;
import org.apache.kafka.clients.consumer.KafkaConsumer;

import java.io.IOException;
import java.util.Arrays;
import java.util.Properties;

/**
 * This program reads messages from two topics.
 */
public class Consumer {

    private static boolean running = true;

    public static void main(String[] args) throws IOException {

        // and the consumer, with minimal config needed to use consumer groups
        Properties props = new Properties();
        props.put("bootstrap.servers", "localhost:9092");
        props.put("group.id", "consumer-tutorial");
        props.put("key.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        props.put("value.deserializer", "org.apache.kafka.common.serialization.StringDeserializer");
        KafkaConsumer<String, String> consumer = new KafkaConsumer<>(props);

        // subscribe to the topics
        consumer.subscribe(Arrays.asList("foo-topic"));

        // basic poll loop. prints the offset and value of fetched records as they arrive
        try {
            while (running) {
                ConsumerRecords<String, String> records = consumer.poll(1000);
                for (ConsumerRecord<String, String> record : records) {
                    System.out.println(record.offset() + ": " + record.value());
                }
            }
        } finally {
            System.out.println("Closing consumer");
            consumer.close();
        }
    }
}

ref:
http://www.confluent.io/blog/tutorial-getting-started-with-the-new-apache-kafka-0.9-consumer-client
