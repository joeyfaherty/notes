# Blueprints
[https://blog.pythian.com/ambari-blueprints-and-one-touch-hadoop-clusters/]

A blueprint defines the logical structure of a cluster, without needing informations about the actual infrastructure. Therefore you can use the same blueprint for different amount of nodes, different IPs and different domain names.


## host groups
* Host groups are a set of machines with the same agents (“components” in Ambari terms) installed – a typical cluster might have host groups for the NameNode, SecondaryNameNode, ResourceManager, DataNodes and client nodes for submitting jobs. 
* The small clusters I’m creating have a “master” node group with the NameNode, ResourceManager, and HiveServer components on a single server and then a collection of “slaves” running the NodeManager and DataNode components. 
* Besides a list of software components to install, every host group has a cardinality.

EG.
{
	"host_groups": [{
			"name": "master",
			"components": [{
					"name": "NAMENODE"
				},
				{
					"name": "SECONDARY_NAMENODE"
				},
				{
					"name": "RESOURCEMANAGER"
				},
				{
					"name": "HISTORYSERVER"
				},
				{
					"name": "ZOOKEEPER_SERVER"
				},
				{
					"name": "HIVE_METASTORE"
				},
				{
					"name": "HIVE_SERVER"
				},
				{
					"name": "MYSQL_SERVER"
				}
			],
			"cardinality": "1"
		},
		{
			"name": "slaves",
			"components": [{
					"name": "DATANODE"
				},
				{
					"name": "HDFS_CLIENT"
				},
				{
					"name": "NODEMANAGER"
				},
				{
					"name": "YARN_CLIENT"
				},
				{
					"name": "MAPREDUCE2_CLIENT"
				},
				{
					"name": "ZOOKEEPER_CLIENT"
				},
				{
					"name": "TEZ_CLIENT"
				},
				{
					"name": "HIVE_CLIENT"
				}
			],
			"cardinality": "5"
		}
	]
}

* This host_groups describes a single node with all of the “master” components installed, and five slaves with just the DataNode, NodeManager and clients installed. 
* Note that some components have depedencies: it’s possible to build an invalid blueprint which contains a HIVE_METASTORE but not a MYSQL_SERVER. 
* The REST API provides appropriate error messages when such a blueprint is submitted.

## configurations

* Configuration allows you to override the defaults for any services you’re installing, and it comes in two varieties: global, and service-specific. 
* Global parameters are required for different services: to my knowledge Nagios and Hive require global parameters to be specified – these parameters apply to multiple roles within the cluster, and the API will tell you if any are missing. 
* Most cluster configuration (your typical core-site.xml, hive-site.xml, etc. parameters) can be overriden in the blueprint by specifying a configuration with the leading part of the file name, and then providing a map of the keys to overwrite. 
* The configuration below provides a global variable that Hive requires, and it also overrides some of the default parameters in hive-site.xml. 
* These changes will be propagated to the cluster as if you changed them in the Ambari UI.

{
	"configurations": [{
			"global": {
				"hive_metastore_user_passwd": "p"
			}
		},
		{
			"hive-site": {
				"javax.jdo.option.ConnectionPassword": "p",
				"hive.security.authenticator.manager": "org.apache.hadoop.hive.ql.security.HadoopDefaultAuthenticator",
				"hive.execution.engine": "tez",
				"hive.exec.failure.hooks": "",
				"hive.exec.pre.hooks": "",
				"hive.exec.post.hooks": ""
			}
		}
	]
}


This config will override some parameters in hive-site.xml, as well as setting the metastore password to ‘p’. Note that you can specify more configuration files to override (core-site.xml, hdfs-site.xml, etc.) but each file must be it’s own object in the configurations array, similar to how global and hive-site are handled above.

Once you’ve specified the host groups and any configuration overrides, the Blueprint also needs a stack – the versions of software to install. Right now Ambari only supports HDP – see this table for the stack versions supported in each Ambari release. As a weird constraint, the blueprint name is inside the blueprint itself, along with the stack information. This name must be the same as the name you provide to the REST endpoint, for some reason. To upload a new blueprint to an Ambari server you can use:


$ curl -X POST -H 'X-Requested-By: Pythian' <ambari-host>/api/v1/blueprints/<blueprint name> -d @<blueprint file>

$ curl -X POST -H 'X-Requested-By: Pythian' <ambari-host>/api/v1/clusters/<cluster name> -d @<mapping file>


Step 4: Register blueprint with ambari server by executing below command

curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://<ambari-hostname>:8080/api/v1/blueprints/<blueprint-name> -d @cluster_configuration.json

Srep 6: Pull the trigger! Below command will start cluster installation.

curl -H "X-Requested-By: ambari" -X POST -u admin:admin http://<ambari-host>:8080/api/v1/clusters/<new-cluster-name> -d @hostmapping.json

Step 7: We can track installation status by below REST call or we can check the same from ambari UI


GET All Clusters:
curl -k -H "X-Requested-By: ambari" -X GET -u USER https://AMBARI_HOST:8081/api/v1/clusters


GET Cluster:
curl -k -H "X-Requested-By: ambari" -X GET -u USER https://AMBARI_HOST:8081/api/v1/clusters/MY_CLUSTER

GET All Blueprints:
curl -k -H "X-Requested-By: ambari" -X GET -u USER https://AMBARI_HOST:8081/api/v1/blueprints


GET Cluster:
curl -k -H "X-Requested-By: ambari" -X GET -u USER https://AMBARI_HOST:8081/api/v1/blueprints/hdp-2.6

 curl -u admin:admin -H "X-Requested-By: ambari" -X GET http://AMBARI_HOST:8080/api/v1/clusters/HDP01?format=blueprint -o /tmp/HDP01_blueprint.json






 

curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://<ambari-hostname>:8080/api/v1/clusters/mycluster/requests/

 

curl -H "X-Requested-By: ambari" -X GET -u admin:admin http://<ambari-hostname>:8080/api/v1/clusters/mycluster/requests/<request-number>