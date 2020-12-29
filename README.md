# cloud-native-demo
This demo sets up a Kubernetes cluster using AWS Elastic Kubernetes Service and deploys a dockerize web app using Jenkins CI/CD pipeline.

---
## Design
The design folder currently shows the initial whiteboard design and the tech stacks that will be used for the demo. 

## Project Info
- Docker image of the app pushed to dockerhub. Repo => dogbern/demoapp:1.0
- Postman screenshots in artifacts folder to test the app works

## Use the below command to run the container
```
docker container run --name web -p 5000:5000 dogbern/demoapp:1.0
```







