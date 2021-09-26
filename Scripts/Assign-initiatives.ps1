#Assign Prerequisite Built-in PolicySet to a management group
$PolicySet = Get-AzPolicySetDefinition -Name "12794019-7a00-42cf-95c2-882eed337cc8"
New-AzPolicyAssignment -Name VM-Guest-OS-Prereq -Scope "/providers/Microsoft.Management/managementGroups/MG-CORE" -DisplayName VM-Guest-OS-Prereq -PolicySetDefinition $PolicySet -AssignIdentity -Location 'westeurope'
