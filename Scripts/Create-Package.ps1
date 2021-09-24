New-GuestConfigurationPackage `
  -Name '7Zip' `
  -Configuration './Install7Zip/DESKTOP-RP9A0AF.mof' `
  -Type AuditAndSet `
  -Force

  New-GuestConfigurationPackage `
  -Name 'IIS' `
  -Configuration './WebsiteTest/DESKTOP-RP9A0AF.mof' `
  -Type AuditAndSet `
  -Force