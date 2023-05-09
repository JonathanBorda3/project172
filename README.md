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

4. Deployed Starbucks API to GKE
inside starbucks api fic the 10 times order bug, not ine memory 

5. Changed stateful session to be stateless in StarbucksServices by removing HashMap. Before the deployment i made sure my api is stateless. (does not store any data in itself, like arraylists or hashmaps), and stores all the data in the database and also in an event queue (RabbitMQ)

6.Next steps: Need to create kong ingress which load balances  (check lab 8 to continue)
