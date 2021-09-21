module VNET 'Templates/Vnet.bicep' = {
  name: 'VnetDelpoyment'
}

module VM 'Templates/VM.bicep' = {
  name: 'VMDeployment'
  dependsOn: [
    VNET
  ]
}
