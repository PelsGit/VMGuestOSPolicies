Configuration WebsiteTest {

    # Import the module that contains the resources we're using.
    Import-DSCResource -ModuleName 'PSDscResources'
    Import-DSCResource -ModuleName 'xWebAdministration'
    

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The first resource block ensures that the Web-Server (IIS) feature is enabled.
        WindowsFeature WebServer {
            Ensure = "Present"
            Name   = "Web-Server"
        }
    }
}
WebsiteTest -OutputPath C:\Local\Repos\VMPolicies\VMGuestOSPolicies\MofFolders\WindowsIIS

#Start-DscConfiguration -Path C:\Local\Repos\VMPolicies\VMGuestOSPolicies\Scripts\WindowsIIS -Wait -Verbose -Force