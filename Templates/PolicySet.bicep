targetScope = 'subscription'

resource PolicySet 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'vm-guest-policy-set'
  properties: {
    policyDefinitions: [
      {
        policyDefinitionId: 'PolicyDefinitionID'
      }
      {
        policyDefinitionId: 'PolicyDefinitionID'
      }
      {
        policyDefinitionId: 'PolicyDefinitionID'
      }
      {
        policyDefinitionId: 'PolicyDefinitionID'
      }
    ]
  }
}

resource initiativeDefinitionPolicyAssignment 'Microsoft.Authorization/policyAssignments@2019-09-01' = {
  name: 'vm-guest-policy-set'
  identity: {
    type: 'SystemAssigned'
  }
  location: 'West Europe'
  properties: {
    scope: subscription().id
    enforcementMode: 'Default'
    policyDefinitionId: PolicySet.id
  }
}
