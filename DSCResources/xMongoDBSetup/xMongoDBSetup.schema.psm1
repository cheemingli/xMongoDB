Configuration xMongoDBSetup
{
    param
    (
        [string]
        $VersionNumber = "3.5.3",
        [string]
        $LocalPath = "$env:USERPROFILE\Downloads\mongodb-win32-x86_64-" + $VersionNumber + "-signed.msi",
        [string]
        $InstallLocation="$env:SystemDrive\Program Files\MongoDB\Server\" + $VersionNumber + "\",
        [string]
        $ComponentSet = "all",
        [ValidateSet("x86", "x64")]
        [string]
        $MachineBits = "x64"
    )

    Import-DscResource -ModuleName xPSDesiredStateConfiguration

    xRemoteFile Downloader
    {
        Uri = "http://downloads.mongodb.org/win32/mongodb-win32-x86_64-" + $VersionNumber + "-signed.msi"
        DestinationPath = $LocalPath
        MatchSource = $False
    }

    $Name = "MongoDB " + $VersionNumber
    if ($MachineBits -eq "x64") 
    {
        $Name += " (64 bit)"
    }
    else{
        $Name += " (32 bit)"
    }

    Package Installer
    {
        Ensure = "Present"
        Path = $LocalPath
        Name = $Name
        Arguments = 'INSTALLLOCATION="' + $InstallLocation + '" ADDLOCAL="' + $ComponentSet + '"'
        ProductId = ""
        DependsOn = "[xRemoteFile]Downloader"
    }
}