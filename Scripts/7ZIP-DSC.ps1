Configuration Install7Zip {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # The first resource block ensures that the Web-Server (IIS) feature is enabled.
        Package 7zip {
            Ensure    = "Present"
            Name      = "7-Zip 19.00"
            Path      = "C:\Local\7z1900-x64.msi"
            ProductId = "23170F69-40C1-2702-1900-000001000000"
        }
    }
}