# Terraform installation

(Terraform cli) https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli


Terraform download: https://www.terraform.io/downloads.html


```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

```

Install the HashiCorp GPG key

```

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

```

Add the official HashiCorp repository to your system

```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt-get install terraform

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
az ad sp create-for-rbac --name tfcloudops --role OwnerContributor --scopes /subscriptions/7996451c-728c-4b55-87f3-dfa8aeac980e

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