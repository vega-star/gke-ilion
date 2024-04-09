# GKE - Ilion

## Infrastructure

The infrastructure of this project consists mainly of:
- A containerized application
- A GKE cluster running the application
- A load balancer to serve the application
- A single Cloud SQL instance providing the database to the application
- A CI/CD pipeline

This project is compacted to mostly fit within free use/low cost scenarios in case of practical experiments, additional testing, and demonstrations. For this purpose, I present some conditionals that can help to fine-tune the deployment:
- The CI/CD pipeline can be integrated with Cloud Build and Container Registry, or just use Github workflows and Act. It defaults to the latter.
- The size, scalability, and complexity of the cluster will be divided in layers. It defaults to the most basic one.
   - Layer 1 (Default): Single cluster in a zone, limited autoscaling, consisting of 2-3 application pods and 1 Helm pod.

## Conclusion

### Why the name Ilion?

The name Ilion refers to the city of Troy, which had both names historically referenced between Ancient Greece and the Hittite Empire, the latter naming the place Wilios before. The reason is simply because I was reading about the history of Troy, just out of curiosity, during the development of this project.
