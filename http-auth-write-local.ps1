# ExportData.ps1
# TODO: review
# TODO: make $Token default "" or something if not given

function Export-Data {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Token,

        [Parameter(Mandatory=$true)]
        [string]$Url,

        [Parameter(Mandatory=$true)]
        [string]$OutFile
    )

    $headers = @{
        Authorization = "Bearer $Token"
    }

    try {
        $response = Invoke-RestMethod -Uri $Url -Headers $headers
        $response | Out-File -FilePath $OutFile -Encoding utf8
        Write-Output "Data export successful. File saved as $OutFile."
    } catch {
        Write-Error "Failed to export data: $_"
    }
}
