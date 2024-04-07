# Copied from this [learn.microsoft blog](https://learn.microsoft.com/en-us/archive/blogs/mediaandmicrocode/get-computersnearme)
# How to make into a module:
## change file extension from .ps1 to .psm1
### [more steps README](https://github.com/PoshCode/ModuleBuilder?tab=readme-ov-file#the-modulebuilder-module)

function Get-ComputersNearMe
{
    <#
    .Synopsis
        Returns the Computers Near Me
    .Description
        Returns all of the computers listed in the "Computers Near Me" or "Access the computers and devices tht are on your network" shell
        namespace.  Uses the Shell.Application API to get the computers folder, and then uses Test-Connection to return the machines and their
        response times.
    .Example
        Get-ComputersNearMe
    #>
    param()
    $computersFolder = 0x12
    $shell = New-Object -ComObject Shell.Application
    $shell.NameSpace($computersFolder).Items() |
        Where-Object { $_.Path -like "\\*" } |
        ForEach-Object {
            Test-Connection $_.Name -AsJob
        } |
        Wait-Job |
        Receive-Job
}