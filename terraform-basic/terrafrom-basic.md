# Hashicorp Terraform

HCL (HashiCorp Configuration Language) Basic

- variables

```


```



## Installation Verifivation



- Enable tab completion
- Configure Redis password in application.yml
- Build the project  
```
terraform --version

terraform -install-autocomplete

```

## Terraform work on Azure

- install azure cli

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

```

- login to azure

```
az login

```

- set the subscriptions

```

az account set --subscription "Demos-id"

```

- Create a service principal

```
az ad sp create-for-rbac --name cloudops --role Owner --scopes /subscriptions/7996451c-728c-4b55-87f3-dfa8aeac980e

```
- set the environment variables

```
 export ARM_CLIENT_ID="<APPID_VALUE>"
 export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
 export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
 export ARM_TENANT_ID="<TENANT_VALUE>

```


### Reference Documentation

 
For further reference, please consider the following sections:

(Terrafrom developer) https://developer.hashicorp.com/terraform/tutorials/azure-get-started/# 