# Basic deployments
New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe"
New-AzResourceGroupDeployment -ResourceGroupName Dev-Pels-02 -TemplateFile main.bicep -Confirm -verbose

Select-AzSubscription fffb0c65-e90a-4b5d-adac-a5d6d399e2cc
New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe" 

# Deploy Storage Account to publish Guest Configuration

$ResourceGroup = "Dev-Pels-GC"
$Location = "West Europe"
$StorageAccountName = sapelstest69
New-AzResourceGroup -Name $ResourceGroup -Location $Location
New-AzStorageAccount -ResourceGroupName $ResourceGroup -Name $StorageAccountName -SkuName 'Standard_LRS' -Location $Location | New-AzStorageContainer -Name guestconfiguration -Permission Blob

Publish-GuestConfigurationPackage -Path ./7Zip.zip -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri

# Create New Custom Guest Policy Definition

New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-IIS' `
  -ContentUri 'https://sapelstest69.blob.core.windows.net/guestconfiguration/IIS.zip?sv=2020-04-08&st=2021-09-25T16%3A31%3A06Z&se=2024-09-25T16%3A31%3A06Z&sr=b&sp=rl&sig=wOzdhDN%2F7VDzNs6lznMSA6Br5oDpYOWIrsGh4IxY7eI%3D'`
  -DisplayName 'VM Guest Policy IIS Deploy' `
  -Description 'This Policy deploys IIS on a VM' `
  -Path './policies/IIS' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

  #Create Policy Definition scoped to a subscription
New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-7Zip'
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\7ZIP\VM-Guest-Policy-7Zip.json' `
    -SubscriptionId 'fffb0c65-e90a-4b5d-adac-a5d6d399e2cc'

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-IIS' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\IIS\VM-Guest-Policy-IIS.json' `
    -SubscriptionId 'fffb0c65-e90a-4b5d-adac-a5d6d399e2cc'