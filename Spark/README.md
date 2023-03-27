

## Starting a driver app with PySpark

``` python
port = 3000 #Dashboard Port
``` 
[Spark config file](https://spark.apache.org/docs/latest/configuration.html)

spark_master = "spark://IP:PORT"
``` python
spark_master = "spark://mohsen-local:7077"

conf = (
    SparkConf()
    .set("spark.app.name", "AppName")
    .set("spark.master", spark_master)
    .set("spark.ui.port", str(port))
)

sc = SparkContext(conf=conf)
spark = SparkSession.builder.getOrCreate()
```

This driver app connects to a Spark cluster.