# JMeter InfluxDB Grafana Docker container

This container setup allows you to immediately synchronize JMeter results with InfluxDB and visualize what is happening in real time.

![Grafana Dashboard](docs/images/Grafana.png)

## Prerequisites
Please make sure both docker and docker-compose are installed.

## Build JMeter docker image
`docker build -t jmeter jmeter-docker`

## Start InfluxDB and Grafana
`docker-compose up -d`

## Adjust JMeter script
Define 2 variables on the Test Plan component.

Name | Value
------------ | -------------
CLIENTNAME | Example
STARTDATETIME | `${__time(yy-MM-dd-HH:mm:ss:SSS)}`
	
Add & configure the Backend Listener in Jmeter.

![JMeter Backend Listener](docs/images/BackendListener.png)

Name | Value
------------ | -------------
influxdbMetricsSender  |  org.apache.jmeter.visualizers.backend.influxdb.HttpMetricsSender
influxdbUrl | http://${__P(INFLUXDB_HOST, localhost)}:8086/write?db=jmeter_results
application	| ${CLIENTNAME}_${STARTDATETIME}
measurement	| jmeter
summaryOnly	| false
samplersRegex | .*
percentiles	| 90;95;99
testTitle	| Test name
eventTags	| 


## Run JMeter script
`./run-specific-jmeter-script.sh example.jmx`

## Filter the correct testrun in Grafana
![Grafana Filter](docs/images/Grafana_filter.png)

It is the concatenation of `CLIENTNAME` and `STARTDATETIME`.

## Disclaimer
Inspired by https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how

# Support This Project

If you find this project useful and want to support its ongoing development, consider <a href="https://www.buymeacoffee.com/roydekleijn"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=roydekleijn&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff" /></a>!

I appreciate your support!
