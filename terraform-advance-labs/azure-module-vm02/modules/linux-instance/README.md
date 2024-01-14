# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Output declarations

Create a module that will create a virtual machine in Azure. The module should accept the following variables:

- `location` - The Azure region where the resource group will be created.
- `resource_group_name` - The name of the resource group in which to create the virtual machine.
- `vm_name` - The name of the virtual machine.
- `vm_size` - The size of the virtual machine.
- `admin_username` - The username of the local administrator to create on the virtual machine.
- `admin_password` - The password of the local administrator to create on the virtual machine.
- `network_interface_ids` - A list of network interface IDs to attach to the virtual machine.
- `os_disk_id` - The ID of the OS disk to attach to the virtual machine.
- `source_image_id` - The ID of the source image to use for the virtual machine.
- `tags` - A map of tags to apply to the virtual machine.
- `boot_diagnostics_storage_account_id` - The ID of the storage account to use for boot diagnostics.
- `custom_data` - The custom data to use for the virtual machine.
- `zones` - A list of availability zones in which to create the virtual machine.
- `enable_accelerated_networking` - Whether to enable accelerated networking on the virtual machine.
- `enable_host_encryption` - Whether to enable host encryption on the virtual machine.
- `enable_msi` - Whether to enable managed service identity on the virtual machine.
- `enable_os_security` - Whether to enable OS security on the virtual machine.
- `enable_ultra_ssd` - Whether to enable ultra SSD on the virtual machine.
- `license_type` - The license type to use for the virtual machine.
- `priority` - The priority to use for the virtual machine.
- `provision_vm_agent` - Whether to provision the VM agent on the virtual machine.
- `proximity_placement_group_id` - The ID of the proximity placement group to use for the virtual machine.
- `single_placement_group` - Whether to use a single placement group for the virtual machine.
- `terminate_notification_time` - The time to wait for notification to terminate the virtual machine.
- `time_zone` - The time zone to use for the virtual machine.
- `write_accelerator_enabled` - Whether to enable write accelerator on the virtual machine.
- `enable_auto_shutdown` - Whether to enable auto shutdown on the virtual machine.
- `auto_shutdown_time` - The time to auto shutdown the virtual machine.
- `enable_auto_update` - Whether to enable auto update on the virtual machine.
- `enable_hotpatching` - Whether to enable hotpatching on the virtual machine.
- `enable_patching` - Whether to enable patching on the virtual machine.
- `enable_ssh` - Whether to enable SSH on the virtual machine.
- `enable_winrm` - Whether to enable WinRM on the virtual machine.
- `winrm_https_listener_certificate_thumbprint` - The WinRM HTTPS listener certificate thumbprint.
- `winrm_https_listener_type` - The WinRM HTTPS listener type.
- `winrm_listener_protocol` - The WinRM listener protocol.
- `winrm_listener_certificate_url` - The WinRM listener certificate URL.
- `winrm_listener_certificate_name` - The WinRM listener certificate name.
- `winrm_listener_certificate_store` - The WinRM listener certificate store.
- `winrm_listener_certificate_password` - The WinRM listener certificate password.
- `winrm_listener_certificate_is_self_signed` - Whether the WinRM listener certificate is self-signed.  