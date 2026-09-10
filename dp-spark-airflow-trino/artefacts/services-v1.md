# platys-platform - List of Services

| Service | Web UI | Rest API 
|-------------- |------|------------
|[airflow-apiserver](./documentation/services/airflow )|<http://localhost:28139>|<http://localhost:28139/api/v2/version>
|[airflow-dag-processor](./documentation/services/airflow )||
|[airflow-db](./documentation/services/airflow )||
|[airflow-scheduler](./documentation/services/airflow )||
|[airflow-statsd-exporter](./documentation/services/statsd-exporter )||
|[awscli](./documentation/services/awscli )||
|[hive-metastore](./documentation/services/hive-metastore )||<http://localhost:9084/iceberg/v1/namespaces>
|[hive-metastore-db](./documentation/services/hive-metastore )||
|[jupyter](./documentation/services/jupyter )|<http://localhost:28888>|
|[markdown-viewer](./documentation/services/markdown-viewer )|<http://localhost:80>|
|[postgresql](./documentation/services/postgresql )||
|[rustfs-1](./documentation/services/rustfs )|<http://localhost:9014>|
|[rustfs-mc](./documentation/services/rustfs )||
|[spark-connect](./documentation/services/spark-connect )|<http://localhost:24040>|<http://localhost:15002>
|[spark-history](./documentation/services/spark-history )|<http://localhost:28117>|<http://localhost:28117/api/v1>
|[spark-master](./documentation/services/spark )|<http://localhost:28304>|
|[spark-thriftserver](./documentation/services/spark-thriftserver )|<http://localhost:28298>|
|[spark-worker-1](./documentation/services/spark )||
|[spark-worker-2](./documentation/services/spark )||
|[trino-1](./documentation/services/trino )|<http://localhost:28082/ui/preview>|
|[wetty](./documentation/services/wetty )|<http://localhost:3001>||

**Note:** init container ("init: true") are not shown