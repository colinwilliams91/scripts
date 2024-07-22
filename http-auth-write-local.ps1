########################################################
# Emulates a `curl` command with Bash ##################
# Expecting the user to know which arguments to pass ###
########################################################
# --> Makes a REST HTTP request to specific URL ########
# --> Applying Authorization Bearer Token if needed ####
# --> Writes to specified output file type #############
########################################################

# function Export-Rest-Data {
#     param (
#         [Parameter(Mandatory=$false)]
#         [string]$Token = "",

#         [Parameter(Mandatory=$true)]
#         [string]$Url,

#         [Parameter(Mandatory=$true)]
#         [string]$OutFile
#     )

#     if ($Token) {
#         $headers = @{
#             Authorization = "Bearer $Token"
#         }
#     } else {
#         $headers = @{}
#     }

#     try {
#         $response = Invoke-RestMethod -Uri $Url -Headers $headers
#         $response | Out-File -FilePath $OutFile -Encoding utf8
#         Write-Output "Data export successful. File saved as $OutFile."
#     } catch {
#         Write-Error "Failed to export data: $_"
#     }
# }

##################################################################
# Same function with User prompts to write vars ##################
# Expecting the user to know which arguments to pass #############
##################################################################

function Export-Rest-Data {
    [string]$Token = "",
    [string]$Url,
    [string]$OutFile

    $Url = Read-Host -Prompt "`nPlease provide the http(s) target URL endpoint"

    Write-Output "`nIf you need to provide an Authorization Bearer Token..."
    Write-Output 'It will be added to the Headers like this: { Authorization = Bearer $Token }'

    $Token = Read-Host -Prompt "`nPlease provide your token as a string or press enter to skip"

    Write-Output = "`nPlease provide the full file path where you would like to write the response..."
    Write-Output = 'The local file will default to your CWD if not specified...'

    $OutFile = Read-Host -Prompt "`nInclude the file extension type you would like to encode to"

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
        Write-Error "Error message: $($_.Exception.Message)"
        Write-Output ""
        Write-Error "Failed to export data: $_"
        Write-Output ""
        Write-Error "Stack trace: $($_.Exception.StackTrace)"
    }
}

#############
# ARRL ASCI #
#############

<#
   #####  #####  #####  ##
    ## ##  ## ##  ## ##  ##
    ##_##  ##_##  ##_##  ##
    #####  ####   ####   ##
    ## ##  ## ##  ## ##  #####
    ##  ## ##  ## ##  ## ######
#>