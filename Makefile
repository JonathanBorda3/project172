all: clean

clean:
	docker system prune --all

network:
	docker network create --driver bridge starbucks

backend:
	docker run --network starbucks --name spring-starbucks-api -td -p 8080:8080 \
	--platform=linux/amd64 paulnguyen/spring-starbucks-api	

cashier:
	docker run --network starbucks --name starbucks-nodejs -td -p 90:9090  \
	-e "api_endpoint=http://spring-starbucks-api:8080" \
	--platform=linux/amd64 paulnguyen/starbucks-nodejs

starbucks-app-run:
	java -cp starbucks-app.jar -Dapiurl="http://34.170.121.136/api" -Dapikey="Zkfokey2311" -Dregister="9621043" starbucks.Main 2>debug.log

