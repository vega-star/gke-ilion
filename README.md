# GKE - Ilion

## Plan

The infrastructure of this project consists mainly of:

- A containerized third-party application
- A GKE cluster running the application
- A load balancer to serve the application
- A single Cloud SQL instance providing the database to the application
- A CI/CD pipeline to test and assure the activity of each component

So, the logical route would be:

1. Upload and store the third-party application in Container Registry, so we can version control the application both directly from the pipeline and the GCP console. The application will be built as a container by the workflow and uploaded with tags tracing the commit.
2. The main pipeline is triggered each time the repo recieves a push, but further actions such as `terraform apply` and `kubectl rollout` will have to wait for manual action in the repo. This is useful to prevent additional costs, or even any cost at all.
3. Deploy a GKE cluster with the service connected to the application, with external application load balancer configured. All of the cluster configuration will be stored in Terraform.
4. Deploy the desired database via Terraform and provide the connection means to the application pods.
5. Create an service account with needed permissions granted and use to process everything at once.

## Application

Firstly, we make sure we install the requirements of the application:

```sh
  pip install -r .\application\requirements.txt
```

## Deploy

To make sure terraform knows what to do, we need to populate our variables, so I left 'template.tfvars' to facilitate the process. Open the file, modify the values with their respective types, and then rename the file to 'terraform.tfvars':

```bash
  PROJECT_ID = [string]
  SELECTED_REGION = [string]
  TF_SERVICE_ACCOUNT_ID = [string]
  DB_INSTANCE_TIER = [string]
  DB_HIGH_AVAILABILITY = [bool]
  [...]
```

> [!WARNING]
> .tfvars can store sensible data, so make sure to rename 'template.tfvars' to 'terraform.tfvars', so git will ignore it.

To test our pipeline, a simple push to branch will trigger a series of tests. The credentials of the service account is supposed to be stored as a secret in the repo, loaded with GitHub Actions. Locally, you can add the credentials of the service account as an environment variable. I left the commands below to help you with that:

```bash
  # | POWERSHELL
  $env:GOOGLE_APPLICATION_CREDENTIALS=(Get-Item credentials.json).FullName  

  # | BASH
  export GOOGLE_APPLICATION_CREDENTIALS=$(realpath ./credentials.json)
```

> [!IMPORTANT]
> As the deploy action is part of a production environment, the **'terraform apply' action will be safely waiting for approval**, so you don't waste resources while testing this setup.

## Conclusion

### Why the name Ilion?

The name Ilion refers to the city of Troy, which had both names historically referenced between Ancient Greece and the Hittite Empire, the latter naming the place Wilios before. The reason is simply because I was reading about the history of Troy, just out of curiosity, during the development of this project.
