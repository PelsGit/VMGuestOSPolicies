Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
Install-Module -Name cChoco -Verbose
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Untrusted

Configuration packageDemo {
    Import-DscResource -ModuleName cChoco
    Node TgtPull {
        cChocoinstaller Install {
            InstallDir = "c:\ProgramData\chocolatey"
            }
        
        cChocoPackageInstaller Install7Zip {
            Name = '7Zip.install'
            DependsOn = '[cChocoInstaller]Install'
            }
        }
    }
PackageDemo