New-GuestConfigurationPackage `
  -Name '7Zip' `
  -Configuration './7ZIPMOF/DESKTOP-RP9A0AF.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'IIS' `
  -Configuration './WindowsIIS/vm-001-weu.mof' `
  -Type AuditAndSet `
  -Force