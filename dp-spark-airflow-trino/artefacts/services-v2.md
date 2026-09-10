# platys-platform - List of Services

| Service | Links | External<br>Port | Internal<br>Port | Description
|--------------|------|------|------|------------
|[airflow-apiserver](./documentation/services/airflow )|[Web UI](http://localhost:28139) - [Rest API](http://localhost:28139/api/v2/version)|28139<br>|8080<br>|Job Orchestration & Scheduler
|[airflow-dag-processor](./documentation/services/airflow )||||Job Orchestration & Scheduler
|[airflow-db](./documentation/services/airflow )||||Job Orchestration & Scheduler
|[airflow-scheduler](./documentation/services/airflow )||||Job Orchestration & Scheduler
|[airflow-statsd-exporter](./documentation/services/statsd-exporter )||||StatsD Exporter for Prometheus
|[awscli](./documentation/services/awscli )||||AWS CLI
|[hive-metastore](./documentation/services/hive-metastore )|[Rest API](http://localhost:9084/iceberg/v1/namespaces)|9083<br>9084<br>|9083<br>9084<br>|Hive Metastore
|[hive-metastore-db](./documentation/services/hive-metastore )||5442<br>|5432<br>|Hive Metastore DB
|[jupyter](./documentation/services/jupyter )|[Web UI](http://localhost:28888)|28888<br>28376-28380<br>|8888<br>4040-4044<br>|Web-based interactive development environment for notebooks, code, and data
|[markdown-viewer](./documentation/services/markdown-viewer )|[Web UI](http://localhost:80)|80<br>|3000<br>|Platys Platform homepage viewer
|[postgresql](./documentation/services/postgresql )||5432<br>|5432<br>|Open-Source object-relational database system
|[rustfs-1](./documentation/services/rustfs )|[Web UI](http://localhost:9014)|9005<br>9014<br>|9000<br>9010<br>|Software-defined Object Storage
|[rustfs-mc](./documentation/services/rustfs )||||RustFS CLI
|[spark-connect](./documentation/services/spark-connect )|[Web UI](http://localhost:24040) - [Rest API](http://localhost:15002)|15002<br>24040<br>|15002<br>4040<br>|Spark Connect
|[spark-history](./documentation/services/spark-history )|[Web UI](http://localhost:28117) - [Rest API](http://localhost:28117/api/v1)|28117<br>|18080<br>|Spark History Server
|[spark-master](./documentation/services/spark )|[Web UI](http://localhost:28304)|28304<br>6066<br>7077<br>4040-4044<br>|28304<br>6066<br>7077<br>4040-4044<br>|Spark Master Node
|[spark-thriftserver](./documentation/services/spark-thriftserver )|[Web UI](http://localhost:28298)|28118<br>28298<br>|10000<br>4040<br>|Spark Thriftserver
|[spark-worker-1](./documentation/services/spark )||28111<br>|28111<br>|Spark Worker Node
|[spark-worker-2](./documentation/services/spark )||28112<br>|28112<br>|Spark Worker Node
|[trino-1](./documentation/services/trino )|[Web UI](http://localhost:28082/ui/preview)|28082<br>28087<br>|8080<br>8443<br>|SQL Virtualization Engine
|[wetty](./documentation/services/wetty )|[Web UI](http://localhost:3001)|3001<br>|3000<br>|A terminal window in Web-Browser|

**Note:** init container ("init: true") are not shown