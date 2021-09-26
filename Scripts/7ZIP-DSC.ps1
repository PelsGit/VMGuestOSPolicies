Configuration Install7Zip {

    Import-DscResource -ModuleName 'PSDscResources'
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node $env:ComputerName {

        Package 7zip {
            Ensure    = "Present"
            Name      = "7-Zip 19.00"
            Path      = "https://sapelstest69.blob.core.windows.net/guestconfiguration/IIS.zip"
            ProductId = "23170F69-40C1-2702-1900-000001000000"
        }
    }
}
Install7Zip -OutputPath C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF

Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\7ZIPMOF -Wait -Verbose -Force