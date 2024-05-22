# This script contains a fn that will rebuild the buffer segments from `split-file.ps1`

# It searches the cwd for files matching filenames that are incrementing digits
# The output should resemble the original file before it was split (contents reassembled in correct order)

# Invoke like this:
# .\converge-files.ps1 -outFile "reassembled_file.zip" -buffSize 4MB

param(
    [string]$outFile,
    [int]$buffSize = 4MB
)

function converge {
  # Get the current working directory
  $currentDir = (Get-Location).Path
  # Construct the full path for the output file
  $outFilePath = Join-Path -Path $currentDir -ChildPath $outFile

  Write-Output "Current working directory: $currentDir"
  Write-Output "Re-assembled file will be written to: $outFilePath"

  $files = Get-ChildItem | Where-Object { $_.Name -match '^\d+$' } | Sort-Object { [int]$_.Name }

  $outStream = [System.IO.File]::OpenWrite($outFilePath)

  foreach ($file in $files) {
    $inStream = [System.IO.File]::OpenRead($file.FullName)
    $buffer = New-Object byte[] $buffSize
    while ($bytesRead = $inStream.Read($buffer, 0, $buffSize)) {
      $outStream.Write($buffer, 0, $bytesRead)
    }
    $inStream.Close()
}

  $outStream.Close()
  Write-Output "Re-assembled file written to $outFilePath"
}

# splatting the $PSBoundParameters variable will pass all the parameter arguments
# that were originally passed to the script, to the `converge` function
converge @PSBoundParameters
