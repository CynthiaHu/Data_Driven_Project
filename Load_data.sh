# assuming already start hadoop, postgres and metastore
# to save file in /data folder where 200GB+ EBS volume attached
# start as w205 user

cd $HOME
cd /data
mkdir taxi_trip
cd taxi_trip/

#download weather data
wget -O weather.csv http://s3.amazonaws.com/cynthiahuw205/weather_data.csv
wc -l weather.csv
# view top 2 records
head -2 weather.csv

#download new data for forecast, it's more like a mockup
wget -O newdata.csv http://s3.amazonaws.com/cynthiahuw205/newdata.csv
# view top 2 records
head -2 newdata.csv

# Get taxi_trip data into EC2 instance, the file is about 43GB, 112.8M rows
# avg speed: 2.27M/s. total time 5 hours
wget -v -O Taxi_Trips.csv "http://data.cityofchicago.org/api/views/wrvz-psew/rows.csv?accessType=DOWNLOAD"
# view top 2 records
head -2 Taxi_Trips.csv
# check number of records which takes a while
ls
wc -l Taxi_Trips.csv


# Put the file into HDFS
# strip the header line, cannot use the same file names otherwise it will delete all records
tail -n +2 weather.csv > weather_no_header.csv
tail -n +2 newdata.csv > newdata_no_header.csv
tail -n +2 Taxi_Trips.csv  > Taxi_Trips_No_Header.csv

# next, move local files to HDFS
# for creating hive tables later, save files in separate subfolders under project folder
# it takes about 20 minutes
hdfs dfs -mkdir taxi_trip_project
hdfs dfs -mkdir taxi_trip_project/taxi_trip
hdfs dfs -mkdir taxi_trip_project/weather
hdfs dfs -mkdir taxi_trip_project/newdata

# move files to the folders
hdfs dfs -put weather_no_header.csv taxi_trip_project/weather
hdfs dfs -put newdata_no_header.csv taxi_trip_project/newdata
hdfs dfs -put Taxi_Trips_No_Header.csv taxi_trip_project/taxi_trip

# check directory and files are in the right place
hdfs dfs -ls /user/w205/taxi_trip_project/taxi_trip
hdfs dfs -ls /user/w205/taxi_trip_project/weather
hdfs dfs -ls /user/w205/taxi_trip_project/newdata



 



