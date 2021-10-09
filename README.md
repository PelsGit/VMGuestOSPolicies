# VMGuestOSPolicies

This Repo contains scripts and Bicep templates to create and deploy custom Azure Virtual Machine GuestPolicies with DeployifNotExists effect. This is currently a preview feature, created by Microsoft. More can be found here:

https://github.com/MicrosoftDocs/azure-docs/blob/master/articles/governance/policy/concepts/guest-configuration-custom.md

## How to use

Please keep an eye out on my Blog: Https://cloudsolutionist.com for a full blogpost. Here I will explain in detail what Guestpolicies are and how to create them.

The following Powershell Scripts contain the Desired State configurations which I used:
* BaseLine.ps1 - Contains a DSC to set a registry on the server
* FeatureSet.ps1 - Contains a DSC to deploy two optional Windows features: Telnet & IIS
* Localadmins.ps1 - Contains a DSC to create a user + group and assign that user to that group
* MSI_Installers.ps1 - Contains a DSC to download and install three applications: 7zip, Chrome and Powershell 7

The following scripts need to be used to create and deploy the Policy Definitions and Initiatives
* Deployments.ps1 - contain various scripts which I use to create the policy definitions, initiatives and assignments
* Create-Package.ps1 - Use this powershell script to create the Gues OS Policy Packages.

The Policy folder contains the Policy Definition outputs. These are the end result of the custom policy creation process and need to be assigned in Azure.
The Templates folder contain all the bicep templates which I use to deploy my Azure resources to Azure. I use Bicep Modules compiled in the Main.bicep.

I created a Yaml Pipeline using Github Actions to deploy the Main.bicep. This will deploy a VNET and VM, which are required to test the custom VM policy definitions The flow is as follows:

* Deploy the VM environment with a -WhatIf statement. This will show what will be deployed
* Deploy the VM environment in the correct RG
* Wait for 15 minutes, the is to allow the DeployIfNot exist effect to trigger. We need this for the Guest policies to work
* Run a custom compliancy task. If the compliancy is non-compliant, the pipeline will fail.

[![.github/workflows/PIpeline.yaml](https://github.com/PelsGit/VMGuestOSPolicies/actions/workflows/PIpeline.yaml/badge.svg)](https://github.com/PelsGit/VMGuestOSPolicies/actions/workflows/PIpeline.yaml)

