Configuration Install7Zip {

    Import-DscResource -ModuleName PsDesiredStateConfiguration 

    Node $env:ComputerName {

        Package 7zip {
            Ensure    = "Present"
            Name      = "7-Zip 19.00"
            Path      = "C:\Local\7z1900-x64.msi"
            ProductId = "23170F69-40C1-2702-1900-000001000000"
        }
    }
}
Install7Zip -OutputPath C:\Local\Install7Zip

Start-DscConfiguration -Path C:\Local\WebsiteTest -Wait -Verbose -Force