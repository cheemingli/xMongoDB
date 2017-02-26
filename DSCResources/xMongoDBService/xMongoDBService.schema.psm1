Configuration xMongoDBService
{
    param
    (
        [string]
        $MongoDBInstallationLocation,
        [string]
        $MongoDBLogLocation = "$env:SystemDrive\mongodb\log",
        [string]
        $MongoDBDataLocation = "$env:SystemDrive\mongodb\data"
    )

    File LogLocation
    {
        Ensure = "Present"
        DestinationPath = $MongoDBLogLocation
        Type = "Directory"
    }

    File DataLocation
    {
        Ensure = "Present"
        DestinationPath = $MongoDBDataLocation
        Type = "Directory"
    }

    Service MongoDBService
    {
        DependsOn = "[File]LogLocation", "[File]DataLocation"
        Ensure = "Present"
        State = "Running"
        StartupType =  "Automatic"
        Name = "MongoDB"
        Path = $MongoDBInstallationLocation + "\bin\mongod.exe --dbpath=" + $MongoDBDataLocation + " --logpath=" + $MongoDBLogLocation + "\mongod.log --service"
    }
}