<a name="readme-top"></a>



<!-- PROJECT LOGO -->
<br />
  <h3 align="center">Daily Journal on Starbucks Project</h3>
<p align="center">
  <img src="https://user-images.githubusercontent.com/22685770/235343403-e84bb1f3-7153-4971-9972-9704c84ba812.jpg" alt="My Image" width="300" height="auto">
</p>



<!-- ABOUT THE PROJECT -->
## About The Project

![day 0 - cashier ui](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/31f0ae33-7615-4892-aa9c-d93115b31850)

<!-- [![Product Name Screen Shot][product-screenshot]](https://example.com) -->

This is the comprehensive project for CMPE 172 (Enterprise Software Development) at San Jose State University, for the Spring 2023 semester. This project is a multi-tiered, end-to-end system composed of several elements:

* A web-based application enabling cashiers to oversee their customers' orders (referred to as the Cashier's app)
* A mobile application facilitating payment for customer orders (termed as the Starbucks app)
* A Starbucks API responsible for processing requests coming from both the Cashier's and Starbucks apps
* A database designed to maintain records of orders and cards

## Architecture

![day 0 - architecture](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/b41c61ce-3222-4d77-a54d-ff86dff93f6e)

The Cashier app and particularly the Starbucks API are designed for scalability, supported by multiple pods. They are capable of managing millions of user requests, and the load balancer assists in distributing these requests across the various pods - an external load balancer for the cashiers, and Kong's internal load balancer for all requests directed towards the Starbucks API.

However, there is a constraint regarding the number of active orders. Only one active order per register can be processed at a given time. Consequently, any request to place a new order in the register will be denied and remain unprocessed. This limitation isn't influenced by the number of pods, as all API pods draw data exclusively from the database and don't contain static data (following the removal of the activeOrders hashmap and subsequent code update).

This system could be enhanced by incorporating RabbitMQ. For example, we could initially send order placement requests to the RabbitMQ queue, where orders would be held pending execution. Then, the API would retrieve the next order from the queue for the register and set it as active, continuing this process until the queue is empty. Regrettably, due to not just time restrictions, but also being able to dequeue from the database, I wasn't able to implement RabbitMQ. Though, I gave it a try and uploaded RabbitMQ in GKE, which works as intended. 

The rest of the necessary technology stack was utilized appropriately for the project, and the accompanying journal provides further details on the project's construction.

<!-- Daily Journals -->

## Day 1 

`date` May 2, 2023
`topic` Kong API

### Purpose

Kong is an API gateway that provides a unified entry point for all your APIs and microservices. It manages and secures APIs by providing features such as authentication, rate limiting, request/response transformations, load balancing, and more.

### Challenges

* It was difficult to be able to connect to Kong API, I had to first work on figuring out the configuration. I had problems using the correct endpoints and ports for the API to connect to my application, after figuring out that, I had problems with my get and post requests. POSTMAN was useful in configuring the parameters such as the correct headers to use in the body of the requests, but with practice and online resources I was able to test my requests against the API.

### Testing

![day 1 - jumpbox http](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/8c12428a-94ff-42af-ad95-d65d65cd3c7d)
![day 1 - kong http apikey](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/0edd3d3e-3a73-42f3-b3cd-fc3386eccf46)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 2

`date` May 3, 2023
`topic` RabbitMQ and GitHub Actions

### Purpose

I wanted to use RabbitMQ because it provides a resilient messaging queue system that aids in asynchronous communication within a software system. It allows me to decouple applications, enabling them to dispatch and receive data without needing immediate processing. This improves the responsiveness and scalability of my applications, by effectively managing data flow and preventing system overload.

Also, another thing I attemted to implement, but again, failed, is to utilize GitHub Actions as it offers a powerful solution for both Continuous Integration (CI) and Continuous Deployment (CD), streamlining the process of code updates and software releases. By automatically building, testing, and deploying applications whenever there's a change to the codebase, it reduces my manual workload. This leads to more consistent and frequent deployments, expediting product development, and enhancing software quality.

### Challenges

* Implementing both RabbitMQ and GitHub Actions posed distinct challenges. With RabbitMQ, the complexity arose from integrating it into the existing system architecture and ensuring its robust performance under high loads, whereas with GitHub Actions, setting up an efficient CI/CD pipeline and troubleshooting failed builds and deployments presented significant hurdles.

### Testing

![day 2 - Rabbit Error](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/076475f4-f497-4e32-98b8-feb6cf1552eb)

Therefore, I wasn't been able to accomplish these task while workin on my final project.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 3

`date` May 4, 2023
`topic` Admin Functionality

### Purpose

Admin functionality serves the crucial role of defining security configurations, such as authentication and authorization rules. It ensures that appropriate access controls are in place, thereby safeguarding sensitive data and functionalities. The admin login, specifically, is an essential part of this security framework, providing a secure way for administrators to access privileged functions and manage the application effectively.

### Challenges

Implementing Spring Security alongside a load balancer in Google Kubernetes Engine (GKE) presented notable challenges. Configuring both to work harmoniously, while maintaining secure user sessions across multiple pods, was complex. Furthermore, ensuring that the load balancer correctly distributed traffic without compromising the security protocols established by Spring Security added to the difficulties. Additionally, managing the routing of requests accurately to ensure that they reached the appropriate services, while maintaining session continuity in a load-balanced environment, also presented a significant challenge.

### Testing

![day 3 - admin screen](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/beb5b791-79f7-4885-84d2-95ef30109d9d)
![day 3 - login](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/467aadd3-9d48-44e2-8af6-e2856733cdc5)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 4

`date` May 5, 2023
`topic` Cloud SQL

### Purpose

I wanted to leverage Google Cloud SQL because it provides a fully-managed relational database service for MySQL, PostgreSQL, and SQL Server. It handles the mundane tasks of database management, such as backups, patch management, and failover, allowing me to focus on developing applications. Moreover, its scalability, high availability, and security features make it an excellent choice for handling my application's data needs.

### Challenges

* Implementing Google Cloud SQL posed a few challenges, the most significant being fine-tuning the database for optimal performance while managing costs. Additionally, ensuring secure connections between the application and the database, as well as configuring the right access privileges without compromising security, were other complex aspects to navigate.

### Testing

<img width="1708" alt="day 4 - cloud sql" src="https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/e548ca53-bfc5-4c7b-848c-1742e70cc262">

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 5

`date` May 6, 2023
`topic` Stateless Session

### Purpose

Before deploying the Starbucks API code, I confirmed that the API is at least stateless, meaning it doesn't retain any data internally, such as arraylists or hashmaps. Instead, it should store all data within the database and an event queue, such as RabbitMQ. As part of your tasks, you'll need to elucidate the design and implementation, relating it back to the business logic. You'll also need to discuss the capabilities and constraints of your API in conjunction with all other components.

### Challenges

* Implementing stateless functionality to shift from using a hashmap to a database connection presented several challenges. The primary issue was managing the transition to a completely different data structure, which required significant code changes and retesting. Additionally, ensuring efficient and reliable database connections for every request, while maintaining high performance and scalability, was a complex task.

### Testing

![day 5 - stateless session](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/0d7279c3-702b-4ca6-95c7-e1ca156bc957)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 6

`date` May 8, 2023
`topic` Office Hours

### Purpose

I needed office hours where I had to meet with the professor to ask questions, seek clarification, and receive individualized support. They provided an opportunity to deepen my understanding of the course material, discuss assignments, and receive guidance, ultimately enhancing my learning experience.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 7

`date` May 8, 2023
`topic` Postman Testing

### Purpose

I also used Postman to interact with the Kong API. By leveraging the environment variables I've set, I can seamlessly test and validate various API endpoints, ensuring their functionality and performance. Postman enables me to send requests, receive responses, and analyze the API's behavior, ultimately helping me ensure the reliability and effectiveness of my Kong API implementation.

### Challenges
 
Firstly, managing the environment variables can be complex, especially when dealing with different environments or configurations. Secondly, understanding the intricacies of the Kong API and its specific authentication methods requires additional research and knowledge. Lastly, accurately simulating various scenarios and handling edge cases during testing can be time-consuming and require meticulous attention to detail. Eventually, I changed current variables to meet Kong API requirements 

![day 7 - 1 ping](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/4f81ec5a-7db1-403c-b3b2-8e1a5ddbe3ae)

### Testing

![day 7 - 2 new card](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/465395df-bf97-4be4-97ed-5702569176bf)
![day 7 - 3 activate card](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/0c231512-84dc-4ad9-9b39-b53ed6ef7e79)
![day 7 - 4 get cards](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/d29bfe61-0295-4832-afd9-ba4bce5fd4a7)
![day 7 - 5 delete all cards](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/539a02cb-277c-4ef8-904b-fd65a9c49f09)
![day 7 - 6 new order](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/1f64b203-5ccc-43d3-965b-6a5377b3ce20)
![day 7 - 7 clear order](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/c0b72e91-a9e8-47a5-a66c-c2e286d31f92)
![day 7 - 8 get order](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/b65b1e3b-b7c6-4374-a0c3-c4299c62dbfb)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 8

`date` May 10, 2023
`topic` Deployment Testing

### Purpose

Scalable platform for running containerized applications offered service discovery and load balancing, which helped in managing my applications more efficiently. Moreover, its ability to scale applications based on traffic or custom metrics ensures optimal resource utilization and application performance.

### Challenges

Main challenges I have faced were:
* Configuration Errors: Pulling from Docker Hub in my deployment yaml with wrong tag number
* Networking Issues: I had to google "my ip address" and paste it in SQL networking to be able to access

### Testing

![day 8 - docker hub](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/3b10c81a-c46e-4c80-84d1-08b9be7061ad)
![day 8 - network](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/bae12fb4-83ce-4c26-a0a3-6200507b544a)


### Improvements

![image](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/a60f8ad7-865f-4d74-801e-146eb0bb2728)
![image](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/e7354089-5961-4740-9e80-61cf94cabc1f)
![image](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/bf7e460a-8ece-45a5-8cf3-ba161bea5227)
![image](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/7fe94df7-215e-4ebd-ac6e-12872450bdce)
![image](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/3a5dedc9-7866-4c3f-a041-ecb17d74beeb)




<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Day 9

`date` May 11, 2023
`topic` Starbucks Cashier

### Purpose

Cashier Web App as it serves as a user-friendly platform for cashiers to manage customer orders efficiently. It provides an intuitive interface for order input, modification, and tracking, streamlining the cashiers' workflow. Additionally, its integration with the backend system and the Starbucks API ensures seamless, real-time updates and coordination with the customer-facing Starbucks app.

### Challenges

* Switching the Cashier Web App from localhost to the Kong API on Google Kubernetes Engine (GKE) posed several challenges. The major hurdle was ensuring a smooth transition and maintaining seamless communication between the web app and the API in the new environment. Additionally, dealing with potential networking and security issues related to the shift to a cloud-based solution was another complex aspect of the transition. Implementing the feature to select a drink, milk, and size in the Cashier Web App also presented its own set of challenges. Designing and integrating these additional user interfaces while ensuring they correctly interact with the backend system and provide a smooth user experience was a complex task.

## Day 10

`date` May 13, 2023
`topic` Final Testing

### Testing

![day 10 - testing](https://github.com/shohinsan/starbucks-enterprise-n-tier/assets/22685770/a9172520-3cdc-47f9-9837-5226706840f5)


