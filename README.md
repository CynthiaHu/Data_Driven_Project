# Data_Driven_Project
The repository is for W205 Final Project - Data Driven.

The whole process takes about 10-12 hours, depending on the network and the instance type.

## Set Up EC2 Instance
EC2 Instance for Lab1-4 can be used but need to attach an EBS volume of 200GB+ for this project.

Start Hadoop, Postgres and Hive Metastore in the instance.

## Download and Run Python3 Setup Script
Execute below as a root user.

$ wget  https://s3.amazonaws.com/cynthiahuw205/python_setup.sh

$ . python_setup.sh

##	Clone The Project Repository
$ su - w205

$ git clone https://github.com/CynthiaHu/Data_Driven_Project.git

$ cd Data_Driven_Project

##	Load Data and Save Files into HDFS
It takes about 5-6 hours to download all data (44GB) and copy them to HDFS, mainly depending on the network speed.

$ . Load_data.sh

##	Create Base Hive Tables
It's quite fast.

$ hive -f hive_trip_ddl.sql

##	Transform Datasets
It takes about 1 hour in Hive.

$ hive -f trip_transforming.sql

##	Aggregate Datasets For Visualization and Forecast
It takes about 5 hours to run.

$ hive -f trip_aggregation.sql

##	Run Python Forecast
Use Python3 for PySpark and execute the python script

$ cd ~

$ cd /data

$ export PYSPARK_PYTHON=python3

$ /data/spark15/bin/spark-submit /data/taxi_trip/trip_forecast.py

##	Connect Tableau
Start Hive server on EC2 instance and then connect Tableau using your instance IP
$ hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000 &
