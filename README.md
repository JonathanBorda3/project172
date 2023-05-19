# CMPE 172 Project Journal
5/8/2023
1.installed kong in docker. I have starbucks api in docker as well and i was able to ping it in docker before deploying it to google GKE.
2. Connected to Cloud SQL. Show table 
in starbucks sql database:

2.1 In my deployment.yaml i’m using my own private IP:
      containers:
        - name: spring-starbucks-api
          image: jonathanborda/spring-starbucks-api:v3.2
          env:
            - name: MYSQL_HOST
              # Localhost
              # value: "mysql"
              # Cloud SQL
              value: 10.13.48.3  (private Ip)



3. Connected RabbitMQ using Single Pod in cloud: (lab 9)

4. Deployed Starbucks API to GKE:
inside starbucks api fic the 10 times order bug, not ine memory 

5. Changed stateful session to be stateless in StarbucksServices by removing HashMap. Before the deployment i made sure my api is stateless. (does not store any data in itself, like arraylists or hashmaps), and stores all the data in the database and also in an event queue (RabbitMQ)

6.created kong ingress which load balances 

5/11/2023

7. next to do: make sure to mark client ip and in cashier i have to do some extra work to make the backend healthy.

5/18/2023 (final draft of project)

<!-- Installation Guide -->
# Final Project Guide
## Starbucks Project

![Project Logo](https://user-images.githubusercontent.com/22685770/235343403-e84bb1f3-7153-4971-9972-9704c84ba812.jpg)

This project is a comprehensive multi-tiered, end-to-end system developed for CMPE 172 (Enterprise Software Development) at San Jose State University during the Spring 2023 semester. It consists of the following components:

- Cashier's app: A web-based application for overseeing customer orders.
- Starbucks app: A mobile application for facilitating customer order payments.
- Starbucks API: Responsible for processing requests from the Cashier's and Starbucks apps.
- Database: Designed to maintain order and card records.

## Architecture

add image

## made With

- Spring
- Java
- MySQL
- Redis
- HTML5
- CSS3
- JavaScript
- Bootstrap
- Postman
- Docker
- Google Cloud
- RabbitMQ

<!-- Getting Started -->
## Getting Started

To set up the project locally, follow these steps:

### Prerequisites

- Maven Dependencies:
mvn package


Postman Import:
- `spring-starbucks-kong-collection.json`
- `starbucks-kong-environment.json`

Docker Desktop:
- MySQL
- Kong API
- Starbucks API
- Starbucks Cashier

Mobile CLI:
- cd project_folder
java -cp starbucks-app.jar -Dapiurl="http://localhost:8080" -Dapikey="2H3fONTa8ugl1IcVS7CjLPnPIS2Hp9dJ" -Dregister="5012349" starbucks.Main 2>debug.log


### Installation

#### starbucks-api

1. Create a Network Bridge:
- docker network create --driver bridge starbucks

2. Create Kong API Docker Instance (include --platform=linux/amd64 if you are using mac):
docker run -d --name kong
--network=starbucks
-e "KONG_DATABASE=off"
-e "KONG_PROXY_ACCESS_LOG=/dev/stdout"
-e "KONG_ADMIN_ACCESS_LOG=/dev/stdout"
-e "KONG_PROXY_ERROR_LOG=/dev/stderr"
-e "KONG_ADMIN_ERROR_LOG=/dev/stderr"
-e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl"
-p 80:8000
-p 443:8443
-p 127.0.0.1:8001:8001
-p 127.0.0.1:8444:8444
kong:2.4.0


3. Create Kong Config File:
docker exec -it kong kong config init /home/kong/kong.yml
docker exec -it kong cat /home/kong/kong.yml >> kong-initial.yml


4. Replace the contents of:

yaml
_format_version: "1.1"

services:
-name: starbucks
  protocol: http
  host: starbucks-api
  port: 8080
  path: /
  plugins:
  -name: key-auth  
  routes:
  -name: api
    paths:
    -/api

consumers:
- username: apiclient
  keyauth_credentials:
  - key: 2H3fONTa8ugl1IcVS7CjLPnPIS2Hp9dJ
  
5. Install HTTPIE:

choco install httpie (Windows)
choco upgrade httpie (Windows)

6. Create a MySQL instance in Docker:

docker run -d --network starbucks --name mysql -td -p 3306:3306 -e MYSQL_ROOT_PASSWORD=cmpe172 mysql:8.0

7. Create MySQL user:

# Login to MySQL
mysql -u root -p

# Enter password: 
cmpe172

# Create database
create database starbucks;

# Create user and grant privileges
create user 'admin'@'%' identified by 'cmpe172';
grant all on starbucks.* to 'admin'@'%';

8. Test HTTPIE:

http GET :8001/status
http GET :8001/config config=@kong.yaml
http --ignore-stdin :8001/config config=@kong.yaml

9. Create starbucks-api Instance:

docker run -d --name starbucks-api \
  --network kong-network -td -e env=dev \
  spring-starbucks-api \
  java -jar -Dspring.profiles.active=dev /srv/spring-starbucks-api-3.1.jar

## Modifying MySQL to Google Cloud SQL

1. Connect to Google Cloud SQL using the following command:

gcloud sql connect mysql8 --user=root --quiet

2. Login to MySQL:

mysql -u private-ip -p -h <INSTANCE_CONNECTION_NAME>:db-name

#### starbucks-cashier
1. Create cashier instance
```
docker run --platform=linux/amd64 --network starbucks -e "MYSQL_HOST=mysql" --name starbucks-cashier -td -p 9090:9090 starbucks-cashier
```

#### Docker Desktop
1. Install HTTPIE (everytime to test apikey)
apt-get update && apt-get install -y httpie

2. Test apikey
http GET localhost:8080/api/ping apikey:2H3fONTa8ugl1IcVS7CjLPnPIS2Hp9dJ
curl http://localhost:

starbucks-app
The starbucks-app consists of several actions:

- Login: Use the login feature.
- Scan: Touch the screen at coordinates (3,3) to initiate the scan.
- Pay: Touch the screen at coordinates (2,2), then touch (3,3) to complete the payment.
- Pay again: To pay again, touch (3,3), then touch (2,2), and finally touch (3,3) to complete the payment.


Before running the starbucks-cashier sub-project, make sure to run the starbucks-api sub-project. After that, follow these step:

- Send a card request from the starbucks-client to the starbucks-cashier.
