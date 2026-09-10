# Data Platform on Platys

This platform runs using [Docker Compose](https://docs.docker.com/compose/). The `docker-compose.yml` and all necessary configuration files can be found in the GitHub repository:

[https://github.com/gschmutz/various-platys-platforms/tree/spark-4.1-jupyter/dp-spark-airflow-trino](https://github.com/gschmutz/various-platys-platforms/tree/spark-4.1-jupyter/dp-spark-airflow-trino)

You can start it using these commands:

## Running the Platform (if you want to run it on another machine)

```bash
export PUBLIC_IP=<public-ip-of-the-machine-running-docker>
export DOCKER_HOST_IP=<private-ip-of-the-machine-running-docker>

docker compose up -d
```

## Tutorials

The tutorials listed below from the [Big Data and Spark Workshop](https://github.com/gschmutz/bigdata-spark-workshop) are compatible with this platform.

**Note:** in order for the tutorials to work seamlessly, we assume that the `dataplatform` alias points to the machine where the platys stack is running, i.e. `3.71.39.194`. This is only important if you work locally and not in Wetty terminal.

| # | Workshop | Description |
|---|----------|-------------|
| 1b | [Working with RustFS Object Storage](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/01b-rustfs-object-storage) | Create buckets, upload files (CSV, JSON, PDF), and browse objects using the RustFS Console, `mc`, and `s3cmd`. Establish the shared S3-compatible storage used by all other workshops. |
| 4 | [Data Reading and Writing using DataFrames](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/04-spark-dataframe) | Read CSV and JSON files from object storage into DataFrames, apply joins and aggregations using the DataFrame API and Spark SQL, write partitioned output, and expose results via the Spark Thrift Server. |
| 5 | [Creating and running a self-contained Spark Application](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/05-spark-application-via-spark-submit) | Package a PySpark transformation pipeline as a standalone Python script with `argparse`, then submit it to the Spark cluster using `spark-submit`. |
| 5a | [Running a Spark Application via Spark Connect](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/05a-spark-application-via-spark-connect) | Connect to Spark remotely using Spark Connect. Runs the same flight-data pipeline as workshop 5 but as a plain Python script (or inside Jupyter) without `docker exec` or `spark-submit`. |
| 6 | [Working with different data types](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/06-data-types) | Read and write data in CSV, JSON, Avro, Parquet, and ORC formats, comparing schema inference, compression, and read performance across row-based and columnar formats. |
| 7a | [Working with the Apache Iceberg Table Format](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/07a-spark-iceberg) | Write airport data as an Apache Iceberg table, perform DML operations, inspect snapshot metadata, query historical versions with time travel, and compact data files. |
| 8 | [Graph Analysis using Spark GraphFrames](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/08-spark-graphframe) | Model airports as vertices and flights as edges, then run graph queries including degree analysis, subgraph filtering, motif finding, PageRank, connected components, shortest paths, and BFS. |
| 9 | [Working with Trino](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/09-sql-on-bigdata-with-trino) | Register refined flight data in the Hive Metastore and query it from Trino using standard SQL, including built-in functions, UDFs, relational database federation, and cross-source query federation. |
| 10a | [Data Ingestion with dlt](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/10a-data-ingestion-with-dlt) | Use the Python-native dlt library to ingest flight data from a local landing zone into object storage, with automatic schema inference, Parquet output, and built-in incremental state tracking. |
| 11a | [Job Scheduling with Airflow 3.x](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/11a-scheduling-with-airflow-3.x) | Author an Airflow 3.x DAG that uploads raw data to object storage and submits a Spark job using the SparkSubmitOperator, then monitor and trigger the pipeline from the Airflow UI. |
| 12 | [Working with dbt and Spark](https://github.com/gschmutz/bigdata-spark-workshop/tree/spark-4.1-jupyter/12-dbt-spark) | Build a layered dbt project (raw → prepared → refined) on top of Spark, covering models, materialization strategies, generic tests, incremental models, documentation, and the MetricFlow semantic layer. |

