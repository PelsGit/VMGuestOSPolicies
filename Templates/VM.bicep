//parameters
param adminUsername string = 'admin01'
param adminPassword string = 'secretpassw0rd!'

//variables west europe
var subnetrefeu = resourceId('Microsoft.Network/virtualNetworks/subnets', vnetnameeu, snet1nameeu)
var vnetnameeu = 'vnet-001-${'eu'}'
var snet1nameeu = 'snet-001-${'eu'}'
var NicNameeu = '${VmNameeu}-nic'
var PipNameeu = '${VmNameeu}-pip'
var VmNameeu = 'vm-001-weu'
var locationeu = 'westeurope'

resource PublicIPAddressVM01 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: PipNameeu
  location: locationeu
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'    
  }
}

resource niceu 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: NicNameeu
  location: locationeu
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          publicIPAddress: {
            id: PublicIPAddressVM01.id
          }
          subnet: {
            id: subnetrefeu
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vmeu 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: VmNameeu
  location: locationeu
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: niceu.id
        }
      ]
    }
    osProfile: {
      computerName: VmNameeu
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
  }
}
