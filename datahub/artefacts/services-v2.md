# platys-platform - List of Services

| Service | Links | External<br>Port | Internal<br>Port | Description
|--------------|------|------|------|------------
|[akhq](./documentation/services/akhq )|[Web UI](http://192.168.1.112:28107) - [Rest API](http://192.168.1.112:28107/api)|28107<br>28320<br>|8080<br>28081<br>|Kafka GUI
|[datahub-actions](./documentation/services/datahub )||||Datahub Data Catalog Action Service
|[datahub-cli](./documentation/services/datahub )||||Datahub Data Catalog CLI
|[datahub-frontend](./documentation/services/datahub )|[Web UI](http://192.168.1.112:28144)|28144<br>|9002<br>|Datahub Data Catalog
|[datahub-gms](./documentation/services/datahub )|[Rest API](http://192.168.1.112:28142/openapi/swagger-ui/index.html http://192.168.1.112:28142/api/graphiql)|28142<br>|8080<br>|Datahub Data Catalog GMS Service
|[datahub-mysql](./documentation/services/mysql )||3307<br>|3306<br>|Datahub Data Catalog MySQL Instance
|[datahub-neo4j](./documentation/services/neo4j )|[Web UI](http://192.168.1.112:17475)|17475<br>17688<br>|7474<br>7687<br>|Datahub Data Catalog Neo4J Instance
|[datahub-opensearch](./documentation/services/opensearch )|[Rest API](http://192.168.1.112:28363)|28363<br>|9200<br>|
|[kafka-1](./documentation/services/kafka )||9092<br>19092<br>29092<br>39092<br>9992<br>1234<br>|9092<br>19092<br>29092<br>39092<br>9992<br>1234<br>|Kafka Broker 1
|[kafka-2](./documentation/services/kafka )||9093<br>19093<br>29093<br>39093<br>9993<br>1235<br>|9093<br>19093<br>29093<br>39093<br>9992<br>1234<br>|Kafka Broker 2
|[kafka-3](./documentation/services/kafka )||9094<br>19094<br>29094<br>39094<br>9994<br>1236<br>|9094<br>19094<br>29094<br>39094<br>9992<br>1234<br>|Kafka Broker 3
|[markdown-viewer](./documentation/services/markdown-viewer )|[Web UI](http://192.168.1.112:80)|80<br>|3000<br>|Platys Platform homepage viewer
|[schema-registry-1](./documentation/services/schema-registry )|[Rest API](http://192.168.1.112:8081)|8081<br>|8081<br>|Confluent Schema Registry|

**Note:** init container ("init: true") are not shown