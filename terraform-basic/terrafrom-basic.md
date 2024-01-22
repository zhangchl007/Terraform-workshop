# Hashicorp Terraform

HCL (HashiCorp Configuration Language) Basic

- terraform workflow on Azure
   - terraform init
       * Copy a Source Module
       * Backend Initialization
       * Child Module Installation
       * Plugin Installation
         -upgrade Upgrade all previously-selected plugins to the newest version that complies with the configuration's version constraints. This will cause Terraform to ignore any selections recorded in the dependency lock file, and to take the newest available version matching the configured version constraints.

        -get-plugins=false — Skip plugin installation.

        Note: Since Terraform 0.13, this option has been superseded by the provider_installation and plugin_cache_dir settings. It should not be used in Terraform versions 0.13+, and this option was removed in Terraform 0.15.

        -plugin-dir=PATH — Force plugin installation to read plugins only from the specified directory, as if it had been configured as a filesystem_mirror in the CLI configuration. If you intend to routinely use a particular filesystem mirror then we recommend configuring Terraform's installation methods globally. You can use -plugin-dir as a one-time override for exceptional situations, such as if you are testing a local build of a provider plugin you are currently developing.

        -lockfile=MODE Set a dependency lockfile mode.

        The valid values for the lockfile mode are as follows:

        readonly: suppress the lockfile changes, but verify checksums against the information already recorded. It conflicts with the -upgrade flag. If you update the lockfile with third-party dependency management tools, it would be useful to control when it changes explicitly.
        
   - terraform plan
   - terraform apply
   - terraform destroy
   - terraform show
   - terraform output
   - terraform import
   - terraform state
   - terraform graph
   - terraform fmt
   - terraform validate
   - terraform taint
   - terraform workspace
   - terraform providers
   - terraform console
   - terraform refresh
   - terraform version
   - terraform login
   - terraform logout

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