#### spark-submit
$ spark-submit --class com.my.package.MySparkDriver target/scala-2.11/my-proj-assembly-1.0.jar

## RDD/DF Manipulation

take() returns an Array so no need to collect()  
`myHugeRDD.take(20).foreach(a => println(a))`

sample() does return an RDD so you may still want to collect()  
`myHugeRDD.sample(true, 0.01).collect().foreach(a => println(a))`

takeSample() returns an Array so no need to collect()  
`myHugeRDD.takeSample(true, 20).foreach(a => println(a))`

`df.head().getInt(0)`


* Spark will spill over to disk if the amount of data to be processed exceeds the RAM of the cluster.



## CONFIG
#### spark.submit.deployMode
* When deploy-mode is client, the Driver Program is not necessarily the master node. You could run spark-submit on your laptop, and the Driver Program would run on your laptop.
* When deploy-mode is cluster, then cluster manager (master node) is used to find a slave having enough available resources to execute the Driver Program. As a result, the Driver Program would run on one of the slave nodes. As its execution is delegated, you can not get the result from Driver Program, it must store its results in a file, database, etc.
    
#### Deploy Modes
    Client mode
        Want to get a job result (dynamic analysis)
        Easier for developing/debugging
        Control where your Driver Program is running
        Always up application: expose your Spark job launcher as REST service or a Web UI
    Cluster mode
        Easier for resource allocation (let the master decide): Fire and forget
        Monitor your Driver Program from Master Web UI like other workers
        Stop at the end: one job is finished, allocated resources are freed
    
#### spark.dynamicAllocation.enabled (false)
* Whether to use dynamic resource allocation, which scales the number of executors registered with this application up and down based on the workload. For more detail, see the description here.

* This requires spark.shuffle.service.enabled to be set. The following configurations are also relevant: spark.dynamicAllocation.minExecutors, spark.dynamicAllocation.maxExecutors, and spark.dynamicAllocation.initialExecutors

#### spark.shuffle.service.enabled (false)
* Enables the external shuffle service. This service preserves the shuffle files written by executors so the executors can be safely removed. This must be enabled if spark.dynamicAllocation.enabled is "true". The external shuffle service must be set up in order to enable it. See dynamic allocation configuration and setup documentation for more information.


# compare two datasets
val diff = rdd2.subtractByKey(rdd1).collect()

val diff = rdd2.subtract(rdd1).collect()

val diff = rdd2.except(rdd1).collect()

# add a jar when running spark-shell
/path/to/spark/spark2-client/bin/spark-shell --jars /usr/hdp/2.5.0.0-1245/hive/lib/hive-contrib-1.2.1000.2.5.0.0-1245.jar

# run a python script with jars in client mode (non cluster mode)
spark-submit --deploy-mode client --jars spark-csv_2.10-1.3.2.jar,commons-csv-1.1.jar,univocity-parsers-1.5.1.jar pyspark_autoDQ.py


Low cluster memory. From The Blog of Florian Dahms

While Spark is build on assuming that you have arbitrary amounts of memory available this is often not true. If memory is a scarce resource it makes sense to turn down both caching and shuffle memory so that you do not encounter "out of memory" exceptions:

sparkConf.set("spark.storage.memoryFraction", "0")
sparkConf.set("spark.shuffle.memoryFraction", "0.1")

These settings will make your jobs perform more like classical map reduce jobs.
