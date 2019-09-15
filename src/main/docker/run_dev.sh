#!/bin/sh
echo "********************************************************"
echo "Waiting for the configuration server to start on port $CONFIGSERVER_PORT"
echo "********************************************************"
while ! `nc -z config.iamray.cn $CONFIGSERVER_PORT`; do sleep 3; done
echo "*******  Configuration Server has started"

echo "********************************************************"
echo "Waiting for the eureka server to start on port $EUREKASERVER_PORT"
echo "********************************************************"
while ! `nc -z discovery.iamray.cn $EUREKASERVER_PORT`; do sleep 3; done
echo "******* Eureka Server has started"

echo "********************************************************"
echo "Waiting for the kafka server to start on port $KAFKA_PORT"
echo "********************************************************"
while ! `nc -z kafkaserver $KAFKA_PORT`; do sleep 3; done
echo "******* Eureka Server has started"

echo "********************************************************"
echo "Starting the Message Server"
echo "********************************************************"
java -Djava.security.egd=file:/dev/./urandom                \
     -Dspring.cloud.config.uri=$CONFIGSERVER_URI            \
     -Deureka.client.serviceUrl.defaultZone=$EUREKASERVER_URI \
     -Dauth-server=$AUTH_URI                                \
     -Dspring.kafka.bootstrap-servers=$KAFKA_URI   \
     -Dspring.profiles.active=$PROFILE                      \
     -Xdebug -Xnoagent -Djava.compiler=NONE                 \
     -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=$REMOTE_DEBUG_PORT \
-jar /usr/local/server/@project.build.finalName@.jar
