########################################################
# Emulates a `curl` command with Bash ##################
# Expecting the user to know which arguments to pass ###
########################################################
# --> Makes a REST HTTP request to specific URL ########
# --> Applying Authorization Bearer Token if needed ####
# --> Writes to specified output file type #############
########################################################

function Export-Rest-Data {
    param (
        [Parameter(Mandatory=$false)]
        [string]$Token = "",

        [Parameter(Mandatory=$true)]
        [string]$Url,

        [Parameter(Mandatory=$true)]
        [string]$OutFile
    )

    if ($Token) {
        $headers = @{
            Authorization = "Bearer $Token"
        }
    } else {
        $headers = @{}
    }

    try {
        $response = Invoke-RestMethod -Uri $Url -Headers $headers
        $response | Out-File -FilePath $OutFile -Encoding utf8
        Write-Output "Data export successful. File saved as $OutFile."
    } catch {
        Write-Error "Failed to export data: $_"
    }
}
