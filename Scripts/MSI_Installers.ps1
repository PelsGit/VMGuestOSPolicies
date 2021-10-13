Configuration InstallMSI {

    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        MsiPackage 7Zip
        {
            ProductId = '{23170F69-40C1-2702-1900-000001000000}'
            Path = 'HTTPSLinktoMSI'
            Ensure = 'Present'
        }
        MsiPackage Powershell7
        {
            ProductId = '{395BA042-240F-404D-8B49-BDC2E812DBE5}'
            Path = 'HTTPSLinktoMSI'
            Ensure = 'Present'
        }
       MsiPackage Chrome
        {
            ProductId = '{39B78995-5EBF-329E-AB09-EC5FF4CB10BC}'
            Path = 'HTTPSLinktoMSI'
            Ensure = 'Present'
        }
    }
}
InstallMSI

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force