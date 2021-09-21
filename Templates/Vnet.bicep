//variables west europe
var NetworkSecurityGroupNameEU = '${vnetnameeu}-${'nsg'}'
var vnetnameeu = 'vnet-001-${'eu'}'
var snet1nameeu = 'snet-001-${'eu'}'
var snet2nameeu = 'snet-002-${'eu'}'
var addressPrefixeu = '10.0.0.0/15'
var SubnetPrefix1eu = '10.0.0.0/24'
var SubnetPrefix2eu = '10.1.0.0/24'
var locationeu = 'westeurope'
var FirewallSubnet = '10.1.1.0/26'

// Azure EU resources
resource nsgeu 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: NetworkSecurityGroupNameEU
  location: locationeu
  properties: {
    securityRules: [
      {
        name: 'allow3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allowICMPInbound'
        properties: {
          priority: 1500
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '*'
          protocol: 'Icmp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allowICMPOutbound'
        properties: {
          priority: 1500
          access: 'Allow'
          direction: 'Outbound'
          destinationPortRange: '3389'
          protocol: 'Icmp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vneteu 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetnameeu
  location: locationeu
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefixeu
      ]
    }
    enableDdosProtection: false
    enableVmProtection: false
    subnets: [
      {
        name: snet1nameeu
        properties: {
          addressPrefix: SubnetPrefix1eu
          networkSecurityGroup: {
            id: nsgeu.id
          }
        }
      }
      {
        name: snet2nameeu
        properties: {
          addressPrefix: SubnetPrefix2eu
          networkSecurityGroup: {
            id: nsgeu.id
          }
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: FirewallSubnet
        }
      }
    ]
  }
}
