targetScope = 'subscription'

resource PolicySet 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: 'vm-guest-policy-set'
  properties: {
    policyDefinitions: [
      {
        policyDefinitionId: '/subscriptions/fffb0c65-e90a-4b5d-adac-a5d6d399e2cc/providers/Microsoft.Authorization/policyDefinitions/VM-Guest-Policy-Base'
      }
      {
        policyDefinitionId: '/subscriptions/fffb0c65-e90a-4b5d-adac-a5d6d399e2cc/providers/Microsoft.Authorization/policyDefinitions/VM-Guest-Policy-Features'
      }
      {
        policyDefinitionId: '/subscriptions/fffb0c65-e90a-4b5d-adac-a5d6d399e2cc/providers/Microsoft.Authorization/policyDefinitions/VM-Guest-Policy-MSI'
      }
      {
        policyDefinitionId: '/subscriptions/fffb0c65-e90a-4b5d-adac-a5d6d399e2cc/providers/Microsoft.Authorization/policyDefinitions/VM-Guest-Policy-LocalAdmins'
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
