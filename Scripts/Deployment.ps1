# Basic deployments

New-AzResourceGroup -Name Dev-Pels-02 -Location "West Europe"
New-AzResourceGroupDeployment -ResourceGroupName Dev-Pels-02 -TemplateFile main.bicep -Confirm -verbose

#Assign Prerequisite Built-in PolicySet to a management group
$Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'
$PolicySet = Get-AzPolicySetDefinition -Id /providers/Microsoft.Authorization/policySetDefinitions/12794019-7a00-42cf-95c2-882eed337cc8
New-AzPolicyAssignment -Name VM-Guest-OS-Prereq -Scope "/providers/Microsoft.Management/managementGroups/MG-CORE" -DisplayName VM-Guest-OS-Prereq -PolicySetDefinition $PolicySet -AssignIdentity -Location 'westeurope'

# Deploy Storage Account to publish Guest Configuration

$ResourceGroup = "RGName" #provide the name of the RG
$Location = "West Europe"
$StorageAccountName = "saname" #provide the name of the storageaccount in lowercase
New-AzResourceGroup -Name $ResourceGroup -Location $Location
New-AzStorageAccount -ResourceGroupName $ResourceGroup -Name $StorageAccountName -SkuName 'Standard_LRS' -Location $Location | New-AzStorageContainer -Name guestconfiguration -Permission Blob

#Publish Guest Packages to SA
$ContentURIMSI = Publish-GuestConfigurationPackage -Path Pathtopackagezipfile -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri
$ContentURI7Baseline = Publish-GuestConfigurationPackage -Path Pathtopackagezipfile -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri
$ContentURFeatureSet = Publish-GuestConfigurationPackage -Path Pathtopackagezipfile -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri
$ContentURLocalAdmins = Publish-GuestConfigurationPackage -Path Pathtopackagezipfile -ResourceGroupName $ResourceGroup -StorageAccountName $StorageAccountName | % ContentUri

# Create New Custom Guest Policy Definition

New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-MSI' `
  -ContentUri $ContentURIMSI `
  -DisplayName 'VM Guest Policy MSI Deploy' `
  -Description 'This Policy deploys several software applications on the Server' `
  -Path './policies/MSI' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose

  New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-Features' `
  -ContentUri $ContentURFeatureSet `
  -DisplayName 'VM Guest Policy FeatureSet Deploy' `
  -Description 'This Policy deploys several mandatory features on a server' `
  -Path './policies/Features' `
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

  New-GuestConfigurationPolicy `
  -PolicyId 'VM-Guest-Policy-LocalAdmins' `
  -ContentUri $ContentURLocalAdmins `
  -DisplayName 'VM Guest Policy Local Admin Deploy' `
  -Description 'This Policy creates a local admin and group' `
  -Path './policies/LocalAdmins' `
  -Platform 'Windows' `
  -Version 1.0.0 `
  -Mode 'ApplyAndAutoCorrect' `
  -Verbose


  #Create Policy Definition scoped to a subscription
$Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-MSI' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\MSI\VM-Guest-Policy-MSI.json' `
    -SubscriptionId $($Subscription.Id)

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-Features' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\Features\VM-Guest-Policy-Features.json' `
    -SubscriptionId $($Subscription.Id)

New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-Base' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\baseline\VM-Guest-Policy-Baseline.json' `
    -SubscriptionId $($Subscription.Id)

    New-AzPolicyDefinition `
    -Name 'VM-Guest-Policy-LocalAdmins' `
    -Policy 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\policies\LocalAdmins\VM-Guest-Policy-LocalAdmins.json' `
    -SubscriptionId $($Subscription.Id)

# Create Policy Initiative and assign it to subscription.
New-AzSubscriptionDeployment -TemplateFile path_to_bicep_template -Location 'west europe'

#Assign Policy Initiative to subscription via powershell (alternative)
$Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise'
$Policy = Get-AzPolicySetDefinition -Name 'vm-guest-policy-set'
New-AzPolicyAssignment -Name 'GuestOSPolicyAssignment' -PolicySetDefinition $Policy -Scope "/subscriptions/$($Subscription.Id)" -AssignIdentity -Location 'west europe'
