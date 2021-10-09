Configuration LocalAdmins
{
    param 
    (        
        [System.String]
        $UserName = 'Admin02',
        
        [System.String]
        $Description = 'Local Admin of Server01',
        
        [System.String]
        $FullName = 'Ad Admin',
        
        [ValidateSet('Present', 'Absent')]
        [System.String]
        $Ensure = 'Present',
        
        [System.Boolean]
        $Disabled = $false,

        [System.Boolean]
        $PasswordNeverExpires = $false,

        [System.Boolean]
        $PasswordChangeRequired = $true,

        [System.Boolean]
        $PasswordChangeNotAllowed = $false
    )
    
    Import-DscResource -ModuleName 'PSDscResources'
    
    Node Localhost {

        User UserResource1
        {
            UserName = $UserName
            Ensure = $Ensure
            FullName = $FullName
            Description = $Description
            Disabled = $Disabled
            PasswordNeverExpires = $PasswordNeverExpires
            PasswordChangeRequired = $PasswordChangeRequired
            PasswordChangeNotAllowed = $PasswordChangeNotAllowed
        }
        Group LocalAdmins
    {
        GroupName = 'LocalAdmins'
        Ensure = 'Present'
        Members = @( 'Admin02', 'Admin01' )
        DependsOn = '[User]UserResource1'
    }
}
    }
LocalAdmins