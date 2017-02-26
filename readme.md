# xMongoDB

The **xMongoDB** module contains the **xMongoDBSetup** and **xMongoDBService** composite resource which allows you to install MongoDB and set it as a Windows service.

## Resources

### xMongoDBSetup

### Required parameters
* **VersionNumber**: Specify the version number of MongoDB to be installed. At the moment version the default version is 3.5.3.

### Optional parameters
* **LocalPath**: The local path on the machine where the installation file should be downloaded or is already available. Important: Version number should match local available installation file.
* **InstallLocation**: The local path on the machine where MongoDB will be installed. Default: c:\program files\mongodb\server\$VersionNumber.
* **ComponentSet**: The MongoDB features which needs to be installed. Default: all.
* **MachineBits**: Specifies the machine's operating system bit number. The default is x64.

### xMongoDBService

### Required parameters
* **MongoDBInstallationLocation**: The local path on the machine where  MongoDB is installed.
* **MongoDBLogLocation**: The local path on the machine where log files should be stored.
* **MongoDBDataLocation**: The local path on the machine where data files should be stored.

## Versions

### Unreleased

### 1.0.0.0

* Initial release with the following resources 
    - xMongoDBSetup
    - xMongoDBService

## Examples

### Install MongoDB as Windows service

```powershell
Configuration Sample_InstallMongoDBService
{
    param
    (
    [Parameter(Mandatory)]
    $VersionNumber
    )

    Import-DscResource -module xMongoDB

    xMongoDBSetup InstallMongoDB
    {
        VersionNumber = $VersionNumber
    }

    xMongoDBService InstallMongoDBService
    {
        MongoDBInstallationLocation = "c:\program files\mongodb\server\" + $VersionNumber
    }
}
```