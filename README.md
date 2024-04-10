# GKE - Ilion

## Initial steps

First, we can test the application on our system by making sure we install the requirements of the application:

```sh
  pip install -r .\application\requirements.txt
```

Now, to test our pipeline, a simple push to branch will trigger a series of tests. The credentials of the service account is supposed to be stored as a secret in the repo, loaded with GitHub Actions. If you want to test the access locally, you can use the same .json stored in the secret and load to your environment with the command below:

#### POWERSHELL

```powershell
  $env:GOOGLE_APPLICATION_CREDENTIALS=(Get-Item credentials.json).FullName
```

#### BASH

```sh
  export GOOGLE_APPLICATION_CREDENTIALS=$(realpath credentials.json)
```

> [!IMPORTANT]
> As the deploy action is part of a production environment, the **'terraform apply' action will be safely waiting for approval**, so you don't waste resources while testing this setup.

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
