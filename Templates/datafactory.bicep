resource datafactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: 'datafactory-pels-DF88'
  location: 'westeurope'
  properties: {
    publicNetworkAccess: 'Disabled'
    encryption: {
      identity: {
        userAssignedIdentity: ManagedIdentity.id
      }
      vaultBaseUrl: keyVault.properties.vaultUri
      keyName: KeyvaultKey.name
      keyVersion: KeyvaultKey.properties.keyUriWithVersion
    }
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'Keyvault-pels-18'
  location: resourceGroup().location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: '79c96093-4cd3-4d06-bfbb-c46c1d47c7a7'
    accessPolicies: []
    sku: {
      name: 'premium'
      family: 'A'
    }
  }
}

resource accesspolicies 'Microsoft.KeyVault/vaults/accessPolicies@2021-06-01-preview' = {
  parent: keyVault
  name: 'add'
  properties: {
    accessPolicies: [
      {
        permissions: {
          keys: [
            'get'
            'unwrapKey'
            'wrapKey'
          ]
        }
        tenantId: '79c96093-4cd3-4d06-bfbb-c46c1d47c7a7'
        objectId: ManagedIdentity.properties.principalId
      }
    ]
  }
}

resource KeyvaultKey 'Microsoft.KeyVault/vaults/keys@2021-06-01-preview' = {
  parent: keyVault
  name: 'KeyvaultKey6'
  properties: {
    kty: 'RSA'
    keySize: 2048
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
  }
}

resource ManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'ManagedIdentityDF'
  location: resourceGroup().location
}
