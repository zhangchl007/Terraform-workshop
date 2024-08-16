Write-Output "Setting up Terraform"
#$StorageAccountName = "tfdemotfstate$(Get-Random)"
$StorageAccountName = "tfdemotfstate21052"
$ResourceGroupName = "tfdemo"
$Location = "westus2"
$ContainerName = "tfstate$(Get-Random)" 
$Env:ARM_CLIENT_ID="xxxx"
$Env:ARM_CLIENT_SECRET="xxxxx"
$Env:ARM_SUBSCRIPTION_ID="xxxxxx"
$Env:ARM_TENANT_ID="xxxxx"
#$Env:ARM_SUBSCRIPTION_NAME="Pay-As-You-Go"
Write-Output "Setting up Azure CLI"
az login --service-principal -u $Env:ARM_CLIENT_ID -p $Env:ARM_CLIENT_SECRET --tenant $Env:ARM_TENANT_ID
Write-Output "Creating Resource Group"
az group create --name $ResourceGroupName --location $Location
if (!(az storage account check-name --name $StorageAccountName --query "nameAvailable" -o tsv)) {
    Write-Output "Get Storage Key"
    $StorageAccountKey = az storage account keys list --resource-group $ResourceGroupName --account-name $StorageAccountName --query "[0].value" -o tsv
    $Env:ARM_ACCESS_KEY=$StorageAccountKey
}
else {
    Write-Output "Creating Storage Account"
    az storage account create --name $StorageAccountName --resource-group $ResourceGroupName --location $Location --sku Standard_LRS
    Write-Output "Creating Storage Container"
    az storage container create --name $ContainerName --account-name $StorageAccountName 
    Write-Output "Creating Service Principal"
    #az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/ffa067fd-36c1-4774-a161-7ebdac9a934f" --name "terraform-sp"
    Write-Output "Get Storage Key"
    $StorageAccountKey = az storage account keys list --resource-group $ResourceGroupName --account-name $StorageAccountName --query "[0].value" -o tsv
    $Env:ARM_ACCESS_KEY=$StorageAccountKey
}

