# spark-platform - List of Services

| Service | Links | External<br>Port | Internal<br>Port | Description
|--------------|------|------|------|------------
|[cassandra-1](./documentation/services/cassandra )||29042<br>7199<br>9160<br>|9042<br>7199<br>9160<br>|wide-column NoSQL database
|[hive-metastore](./documentation/services/hive-metastore )||9083<br>|9083<br>|Hive Metastore
|[hive-metastore-db](./documentation/services/hive-metastore )||||Hive Metastore DB
|[influxdb2](./documentation/services/influxdb2 )|[Web UI](http://192.168.1.104:19999) - [Rest API](http://192.168.1.104:19999/api/v2)|19999<br>|8086<br>|Timeseries Database
|[jupyter](./documentation/services/jupyter )|[Web UI](http://192.168.1.104:28888)|28888<br>28376-28380<br>|8888<br>4040-4044<br>|Web-based interactive development environment for notebooks, code, and data
|[markdown-viewer](./documentation/services/markdown-viewer )|[Web UI](http://192.168.1.104:80)|80<br>|3000<br>|Platys Platform homepage viewer
|[minio-1](./documentation/services/minio )|[Web UI](http://192.168.1.104:9000)|9000<br>9010<br>|9000<br>9010<br>|Software-defined Object Storage
|[minio-mc](./documentation/services/minio )||||MinIO Console
|[spark-history](./documentation/services/spark-historyserver )|[Web UI](http://192.168.1.104:28117) - [Rest API](http://192.168.1.104:28117/api/v1)|28117<br>|18080<br>|Spark History Server
|[spark-master](./documentation/services/spark )|[Web UI](http://192.168.1.104:28304)|28304<br>6066<br>7077<br>4040-4044<br>|28304<br>6066<br>7077<br>4040-4044<br>|Spark Master Node
|[spark-thriftserver](./documentation/services/spark-thriftserver )|[Web UI](http://192.168.1.104:28298)|28118<br>28298<br>|10000<br>4040<br>|Spark Thriftserver
|[spark-worker-1](./documentation/services/spark )||28111<br>|28111<br>|Spark Worker Node
|[spark-worker-2](./documentation/services/spark )||28112<br>|28112<br>|Spark Worker Node|

**Note:** init container ("init: true") are not shown