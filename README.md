# GKE - Ilion

## Plan

The infrastructure of this project consists mainly of:

- A containerized application
- A GKE cluster running the application
- A load balancer to serve the application
- A single Cloud SQL instance providing the database to the application
- A CI/CD pipeline

## Application

Firstly, we make sure we install the requirements of the application:

```sh
  pip install -r .\application\requirements.txt
```

## Pipeline

To make sure terraform knows what to do, we need to populate our variables, so I left 'template.tfvars' to facilitate the process:

```bash
  PROJECT_ID = [string]
  SELECTED_REGION = [string]
  TF_SERVICE_ACCOUNT_ID = [string]
  DB_INSTANCE_TIER = [string]
  DB_HIGH_AVAILABILITY = [bool]
```

> [!WARNING]
> .tfvars can store sensible data, so make sure to rename 'template.tfvars' to 'terraform.tfvars', so git will ignore it.

To test our pipeline, a simple push to branch will trigger a series of tests. The credentials of the service account is supposed to be stored as a secret in the repo, loaded with GitHub Actions. If you want to test the access locally, you can use the same .json stored in the secret and load to your environment with the command below:

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

## Conclusion

### Why the name Ilion?

The name Ilion refers to the city of Troy, which had both names historically referenced between Ancient Greece and the Hittite Empire, the latter naming the place Wilios before. The reason is simply because I was reading about the history of Troy, just out of curiosity, during the development of this project.
