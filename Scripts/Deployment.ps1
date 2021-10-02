# Basic deployments

New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe"
New-AzResourceGroupDeployment -ResourceGroupName Dev-Pels-02 -TemplateFile main.bicep -Confirm -verbose

Select-AzSubscription fffb0c65-e90a-4b5d-adac-a5d6d399e2cc
New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe" 

#Assign Prerequisite Built-in PolicySet to a management group
$PolicySet = Get-AzPolicySetDefinition -Name "12794019-7a00-42cf-95c2-882eed337cc8"
New-AzPolicyAssignment -Name VM-Guest-OS-Prereq -Scope "/providers/Microsoft.Management/managementGroups/MG-CORE" -DisplayName VM-Guest-OS-Prereq -PolicySetDefinition $PolicySet -AssignIdentity -Location 'westeurope'

# Deploy Storage Account to publish Guest Configuration

$ResourceGroup = "Dev-Pels-GC"
$Location = "West Europe"
$StorageAccountName = "sapelstest69"
New-AzResourceGroup -Name $ResourceGroup -Location $Location
New-AzStorageAccount -ResourceGroupName $ResourceGroup -Name $StorageAccountName -SkuName 'Standard_LRS' -Location $Location | New-AzStorageContainer -Name guestconfiguration -Permission Blob

#Publish Guest Packages to SA
$ContentURI7ZIP = Publish-GuestConfigurationPackage -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7Zip\7Zip.zip -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri
$ContentURI7Baseline = Publish-GuestConfigurationPackage -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\Baseline\Baseline.zip -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri
$ContentURIIIS = Publish-GuestConfigurationPackage -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\IIS\IIS.zip -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri

# Create New Custom Guest Policy Definition

New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-IIS' `
  -ContentUri $ContentURIIIS `
  -DisplayName 'VM Guest Policy IIS Deploy' `
  -Description 'This Policy deploys IIS on a VM' `
  -Path './policies/IIS' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

  New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-7Zip' `
  -ContentUri $ContentURI7ZIP `
  -DisplayName 'VM Guest Policy 7Zip Deploy' `
  -Description 'This Policy deploys 7Zip on a VM' `
  -Path './policies/7zip' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

  New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-Baseline' `
  -ContentUri $ContentURI7Baseline `
  -DisplayName 'VM Guest Policy Baseline Deploy' `
  -Description 'This Policy deploys Baseline Security settings on a VM' `
  -Path './policies/baseline' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

  #Create Policy Definition scoped to a subscription
  $Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-7Zip' `
    -Policy C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\7ZIP\VM-Guest-Policy-7Zip.json `
    -SubscriptionId $($Subscription.Id)

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-IIS' `
    -Policy C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\IIS\VM-Guest-Policy-IIS.json `
    -SubscriptionId $($Subscription.Id)

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-Base' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\baseline\VM-Guest-Policy-Base.json' `
    -SubscriptionId $($Subscription.Id)

# Create Policy Initiative
New-AzPolicySetDefinition -Name vm-guest-policy-set -PolicyDefinition .\Templates\VM-Guest-Policy-Set.json -Description 'This Policy initiative contains all the policy definitions for guest OS policies' -Metadata '{"category":"Guest Configuration"}'
Set-AzPolicySetDefinition -Name vm-guest-policy-set -Description 'This Policy initiative contains all the policy definitions for guest OS policies' -Metadata '{"category":"Guest Configuration"}'

#Assign Policy Initiative to subscription

$Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'
$Policy = Get-AzPolicySetDefinition -Name 'vm-guest-policy-set'
New-AzPolicyAssignment -Name 'GuestOSPolicyAssignment' -PolicySetDefinition $Policy -Scope "/subscriptions/$($Subscription.Id)" -AssignIdentity -Location 'west europe'
