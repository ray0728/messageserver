![travis_ci](https://www.travis-ci.org/ray0728/messageserver.svg?branch=master)
# messageserver
## 说明
基于Spring Cloud Stream的消息推送管理服务。
* 需配合KAFKA使用
* 提供四个Topic供其他服务使用
  * HLS  
    由[GatewayServer][1]服务消费，指明视频文件的HLS分片任务是否完成
  * NEWS  
    由[GatewayServer][1]服务消费，指明有新的广播消息需要显示在页面中
  * SMS  
    *暂无消费者*
  * FEEDBACK  
    由[DashboardServer][2]服务消费，仅**运维**使用

## ToDo
* 未对做安全授权验证

## 运行方式：  
application.properties中并**不包含**完整配置信息，所以**不支持**直接运行  
* java 方式

```java
java
-Djava.security.egd=file:/dev/./urandom                  \
-Dspring.cloud.config.uri=$CONFIGSERVER_URI              \
-Deureka.client.serviceUrl.defaultZone=$EUREKASERVER_URI \
-Dauth-server=$AUTH_URI                                  \
-Dspring.kafka.bootstrap-servers=$KAFKA_URI              \
-Dspring.profiles.active=$PROFILE                        \
-jar target.jar
```
* docker 方式  
建议用docker-compose方式运行

```docker
messageserver:
  image: ray0728/messageserv
  ports:
    - "10007:10007"
  environment:
    CONFIGSERVER_PORT: "10002"
    EUREKASERVER_PORT: "10001"
    KAFKA_PORT: "9092"
    AUTH_PORT: "10004"
    CONFIGSERVER_URI: 配置服务地址
    EUREKASERVER_URI: EUREKA服务地址
    AUTH_URI: AUTH服务地址
    KAFKA_URI: KAFKA地址
    PROFILE: "dev"
```  
关于Docker  
编译完成的Docker位于[Dockerhub][3]请结合Release中的[Tag标签][4]获取对应的Docker

[1]:https://github.com/ray0728/gatewayserver
[2]:https://github.com/ray0728/dashboardserver
[3]:https://hub.docker.com/r/ray0728/messageserv/tags
[4]:https://github.com/ray0728/messageserver/tags
