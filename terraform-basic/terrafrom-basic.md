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
        * Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
        * Compares the current configuration to the prior state and noting any differences.
        * Proposes a set of change actions that should, if applied, make the remote objects match the configuration.

   - terraform apply
        The following options change how the apply command executes and reports on the apply operation.

        -auto-approve - Skips interactive approval of plan before applying. This option is ignored when you pass a previously-saved plan file, because Terraform considers you passing the plan file as the approval and so will never prompt in that case.

        -compact-warnings - Shows any warning messages in a compact form which includes only the summary messages, unless the warnings are accompanied by at least one error and thus the warning text might be useful context for the errors.

        -input=false - Disables all of Terraform's interactive prompts. Note that this also prevents Terraform from prompting for interactive approval of a plan, so Terraform will conservatively assume that you do not wish to apply the plan, causing the operation to fail. If you wish to run Terraform in a non-interactive context, see Running Terraform in Automation for some different approaches.

        -json - Enables the machine readable JSON UI output. This implies -input=false, so the configuration must have no unassigned variable values to continue. To enable this flag, you must also either enable the -auto-approve flag or specify a previously-saved plan.

        -lock=false - Don't hold a state lock during the operation. This is dangerous if others might concurrently run commands against the same workspace.

        -lock-timeout=DURATION - Unless locking is disabled with -lock=false, instructs Terraform to retry acquiring a lock for a period of time before returning an error. The duration syntax is a number followed by a time unit letter, such as "3s" for three seconds.

        -no-color - Disables terminal formatting sequences in the output. Use this if you are running Terraform in a context where its output will be rendered by a system that cannot interpret terminal formatting.

        -parallelism=n - Limit the number of concurrent operation as Terraform walks the graph. Defaults to 10.

        All planning modes and planning options for terraform plan - Customize how Terraform will create the plan. Only available when you run terraform apply without a saved plan file.
   - terraform destroy
   - terraform show
   - terraform output
   - terraform import
      * terraform import terraform id azure resource id
        * terraform import azurerm_resource_group.rg /subscriptions/ffa067fd-36c1-4774-a161-7ebdac9a934f/resourceGroups/rgtf-learn-terraform-demo
  
   - terraform state management
     * Inspecting State
        Terraform includes some commands for reading and updating state without taking any other actions.

        > The terraform state list command shows the resource addresses for every resource Terraform knows about in a configuration, optionally filtered by partial resource address.

        > The terraform state show command displays detailed state data about one resource.

        > The terraform refresh command updates state data to match the real-world condition of the managed resources. This is done automatically during plans and applies, but not when interacting with state directly

    * Forcing Re-creation of Resources
        terraform apply -replace="azurerm_resource_group.rg"
        terraform apply -replace="azurerm_resource_group.rg,azurerm_virtual_network.vnet"
        terrafrom taint azurerm_resource_group.rg
        terrafrom untaint azurerm_resource_group.rg
    * moving state
        terraform state mv azurerm_resource_group.rg azurerm_resource_group.rg2
        terraform state rm azurerm_resource_group.rg
    * Disaster Recovery
        terraform state pull > terraform.tfstate
        terraform state push terraform.tfstate
        terraform force-unlock LOCK_ID
        
   - terraform graph
   - terraform fmt
   - terraform validate
   - terraform workspace
   - terraform providers
   - terraform console
   - terraform refresh
   - terraform version
   - terraform login
   - terraform logout


## ITesting Terraform
  - Terraform provides numerous testing capabilities to validate your infrastructure.

  - These testing capabilities fit into two main categories:

  - Validating your configuration and infrastructure as part of your regular Terraform operations.
    Performing traditional unit and integration testing on your configuration.

    The test command
    The Terraform test command:

    Locates Terraform testing files within your configuration directory.
    Provisions the infrastructure within your configuration as specified by each testing file.
    Runs the assertions from the test file against the provisioned infrastructure.
    Destroys the provisioned infrastructure at the end of the test.

## Terraform work on Azure

- install azure cli

```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

```

### Reference Documentation

 
For further reference, please consider the following sections:

(Terrafrom developer) https://developer.hashicorp.com/terraform/tutorials/azure-get-started/# 