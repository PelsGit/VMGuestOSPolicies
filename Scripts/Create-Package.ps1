New-GuestConfigurationPackage `
  -Name '7Zip' `
  -Configuration 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\MofFolders\7ZIPMOF\localhost.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'IIS' `
  -Configuration 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\MofFolders\WindowsIIS\localhost.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'Baseline' `
  -Configuration 'C:\Local\Repos\VMPolicies\VMGuestOSPolicies\MofFolders\WindowsSecurityBaseline2016\localhost.mof' `
  -Type AuditAndSet `
  -Force