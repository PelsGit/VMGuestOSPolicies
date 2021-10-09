Configuration FeatureSet {

[CmdletBinding()]
    param ()

Import-DscResource -ModuleName PSDscResources
    
         WindowsOptionalFeatureSet  FeatureSet {
            Ensure = "Present"
            Name   = @("Web-Server", 'Telnet-Client')
        }
    }
FeatureSet

#Start-DscConfiguration -Path C:\Local\Scripts\WebsiteTest -Wait -Verbose -Force