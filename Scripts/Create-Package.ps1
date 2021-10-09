New-GuestConfigurationPackage `
  -Name 'localAdmins' `
  -Configuration 'C:\Local\Scripts\localadmins\localhost.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'FeatureSet' `
  -Configuration 'C:\Local\Scripts\FeatureSet\localhost.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'Baseline' `
  -Configuration 'C:\Local\Scripts\WindowsSecurityBaseline2016\localhost.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'InstallMSI' `
  -Configuration 'C:\Local\Scripts\InstallMSI\localhost.mof' `
  -Type AuditAndSet `
  -Force