Configuration InstallMSI {

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage 7Zip
        {
            ProductId = '{23170F69-40C1-2702-1900-000001000000}'
            Path = 'https://sapelstest69.blob.core.windows.net/guestconfiguration/7z1900-x64.msi'
            Ensure = 'Present'
        }
        MsiPackage Powershell7
        {
            ProductId = '{395BA042-240F-404D-8B49-BDC2E812DBE5}'
            Path = 'https://sapelstest69.blob.core.windows.net/guestconfiguration/PowerShell-7.1.4-win-x64.msi'
            Ensure = 'Present'
        }
       MsiPackage Chrome
        {
            ProductId = '{39B78995-5EBF-329E-AB09-EC5FF4CB10BC}'
            Path = 'https://sapelstest69.blob.core.windows.net/guestconfiguration/GoogleChromeStandaloneEnterprise64.msi'
            Ensure = 'Present'
        }
    }
}
InstallMSI

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force